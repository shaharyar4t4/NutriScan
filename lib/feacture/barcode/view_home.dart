import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _barcode;
  bool _isLoading = false;

  Future<void> scanBarcode() async {
    try {
      setState(() {
        _isLoading = true;
      });
      ScanResult result = await BarcodeScanner.scan();
      String barcode = result.rawContent;
      print('Scanned Barcode: $barcode');

      if (barcode.isNotEmpty) {
        barcode = barcode.trim().replaceAll(RegExp(r'[^0-9]'), '');
        print('Normalized Barcode: $barcode');

        Product? product = await fetchProductByBarcode(barcode);
        setState(() {
          _barcode = barcode;
          _isLoading = false;
        });
        if (product != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Product with barcode $barcode not found in Open Food Facts database. Help us by adding it!',
              ),
              action: SnackBarAction(
                label: 'Contribute',
                onPressed: () async {
                  const url = 'https://world.openfoodfacts.org/contribute';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Could not open contribution page')),
                    );
                  }
                },
              ),
            ),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No barcode detected. Please try again.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning barcode: $e')),
      );
    }
  }

  Future<Product?> fetchProductByBarcode(String barcode) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'No internet connection. Please connect and try again.')),
        );
        return null;
      }

      OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'FoodProductApp');
      ProductQueryConfiguration configuration = ProductQueryConfiguration(
        barcode,
        version: ProductQueryVersion.v3,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
      );

      ProductResultV3? result;
      for (int attempt = 1; attempt <= 2; attempt++) {
        try {
          result = await OpenFoodAPIClient.getProductV3(configuration);
          print('Attempt $attempt - API Response Status: ${result.status}');
          print(
              'Attempt $attempt - API Response Product: ${result.product?.toJson()}');

          return result.product;
        } catch (e) {
          print('Attempt $attempt - Error fetching product: $e');
          if (attempt == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to fetch product after retries: $e')),
            );
            break;
          }
          await Future.delayed(Duration(seconds: 1));
        }
      }

      if (result == null || result.status != 1 || result.product == null) {
        print(
            'Product not found with getProductV3. Trying fallback HTTP request...');
        try {
          final response = await http.get(
            Uri.parse(
                'https://world.openfoodfacts.org/api/v3/product/$barcode.json'),
            headers: {'User-Agent': 'FoodProductApp'},
          );
          print('Fallback HTTP Response: ${response.body}');
          final fallbackResult = jsonDecode(response.body);
          if (fallbackResult['status'] == 1 &&
              fallbackResult['product'] != null) {
            final productJson = fallbackResult['product'];
            return Product(
              barcode: productJson['_id'] ?? barcode,
              productName:
                  productJson['product_name'] ?? productJson['generic_name'],
              ingredientsText: productJson['ingredients_text'],
              nutriments: productJson['nutriments'] != null
                  ? Nutriments.fromJson(productJson['nutriments'])
                  : null,
              brands: productJson['brands'],
              categories: productJson['categories'],
            );
          }
        } catch (e) {
          print('Fallback HTTP Error: $e');
        }
        return null;
      }
      return null;
    } catch (e) {
      print('Error fetching product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch product: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Product Scanner')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: scanBarcode,
                    child: Text('Scan Barcode'),
                  ),
                  SizedBox(height: 16),
                  if (_barcode != null) Text('Last Scanned: $_barcode'),
                ],
              ),
      ),
    );
  }
}
