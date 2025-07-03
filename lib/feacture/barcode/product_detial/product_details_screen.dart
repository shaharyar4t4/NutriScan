import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    print('Received Product: ${product.toJson()}');
    print('Nutriments: ${product.nutriments?.toJson()}');

    return Scaffold(
      appBar: AppBar(title: Text(product.productName ?? 'Unknown Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Product Name:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(product.productName ?? 'Not available'),
            SizedBox(height: 16),
            Text(
              'Brands:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(product.brands ?? 'Not available'),
            SizedBox(height: 16),
            Text(
              'Categories:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(product.categories ?? 'Not available'),
            SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(product.ingredientsText ?? 'Not available'),
            SizedBox(height: 16),
            Text(
              'Calories:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              _formatValue(product.nutriments.extractEnergyKcal(), 'kcal'),
            ),
            SizedBox(height: 16),
            Text(
              'Nutrients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Fat: ${_formatValue(product.nutriments.extractFat(), 'g')}\n'
              'Sugar: ${_formatValue(product.nutriments.extractSugars(), 'g')}\n'
              'Protein: ${_formatValue(product.nutriments.extractProteins(), 'g')}',
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(double? value, String unit) {
    if (value == null) {
      return 'N/A';
    } else {
      return '${value.toStringAsFixed(1)} $unit';
    }
  }
}

// 🔥 New safer extension:
extension NutrimentsSafeExtract on Nutriments? {
  double? extractEnergyKcal() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['energy-kcal_serving']) ??
        _parseToDouble(map['energy-kcal_100g']) ??
        _parseToDouble(map['energy-kcal']) ??
        _parseToDouble(map['energyKcal']);
  }

  double? extractFat() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['fat_serving']) ??
        _parseToDouble(map['fat_100g']) ??
        _parseToDouble(map['fat']);
  }

  double? extractSugars() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['sugars_serving']) ??
        _parseToDouble(map['sugars_100g']) ??
        _parseToDouble(map['sugars']);
  }

  double? extractProteins() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['proteins_serving']) ??
        _parseToDouble(map['proteins_100g']) ??
        _parseToDouble(map['proteins']);
  }
}

double? _parseToDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
