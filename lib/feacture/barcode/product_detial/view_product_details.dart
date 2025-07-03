import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/barcode/product_detial/product_detial_controller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController();

    // Collect available image URLs using controller
    final List<String> imageUrls = controller.getImageUrls(product);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: bg_down),
            onPressed: () {
              Get.toNamed('/navbar');
            },
          ),
          backgroundColor: card_bg,
          title: Text(
            product.productName ?? 'Unknown Product',
            style: TextStyle(color: bg_down),
          )),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // PageView for multiple images
            imageUrls.isNotEmpty
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PageView.builder(
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          imageUrls[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 200,
                            color: Colors.grey[100],
                            child: Center(child: Text('Image not available')),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('No images available')),
                  ),
            SizedBox(height: 16),
            // Product Info Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    Text(product.productName ?? 'Not available'),
                    Divider(),
                    Text('Brands:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    Text(product.brands ?? 'Not available'),
                    Divider(),
                    Text('Categories:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    Text(product.categories ?? 'Not available'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Calories and Nutrients Card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Calories:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    Text(
                      controller.formatValue(
                          product.nutriments.extractEnergyKcal(), 'kcal'),
                    ),
                    Divider(),
                    Text('Nutrients:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    Text(
                      'Fat: ${controller.formatValue(product.nutriments.extractFat(), 'g')}\n'
                      'Sugar: ${controller.formatValue(product.nutriments.extractSugars(), 'g')}\n'
                      'Protein: ${controller.formatValue(product.nutriments.extractProteins(), 'g')}',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Ingredients Table
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredients:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    SizedBox(height: 8),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Ingredient',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Details',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        if (product.ingredientsText != null &&
                            product.ingredientsText!.isNotEmpty)
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('All Ingredients'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(product.ingredientsText!),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
