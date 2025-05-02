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
            // Text("Hello"),
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
              '${product.nutriments?.energyKcal ?? 'N/A'} kcal',
            ),
            SizedBox(height: 16),
            Text(
              'Nutrients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              product.nutriments != null
                  ? 'Fat: ${product.nutriments.fat ?? 'N/A'}g\n'
                      'Sugar: ${product.nutriments.sugars ?? 'N/A'}g\n'
                      'Protein: ${product.nutriments.proteins ?? 'N/A'}g'
                  : 'Not available',
            ),
          ],
        ),
      ),
    );
  }
}

extension NutrimentsExtension on Nutriments? {
  double? get energyKcal {
    if (this == null) return null;
    return this!.energyKcal ??
        this!.toJson()['energy_kcal'] as double? ??
        this!.toJson()['energy-kcal'] as double?;
  }

  double? get fat {
    if (this == null) return null;
    return this!.fat ?? this!.toJson()['fat'] as double?;
  }

  double? get sugars {
    if (this == null) return null;
    return this!.sugars ?? this!.toJson()['sugars'] as double?;
  }

  double? get proteins {
    if (this == null) return null;
    return this!.proteins ?? this!.toJson()['proteins'] as double?;
  }
}
