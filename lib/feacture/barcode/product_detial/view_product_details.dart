import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/barcode/product_detial/product_detial_controller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    controller.sendToPredictionAPI(product);
    final List<String> imageUrls = controller.getImageUrls(product);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: bg_down),
          onPressed: () => Get.toNamed('/navbar'),
        ),
        backgroundColor: card_bg,
        title: Text(
          product.productName ?? 'Unknown Product',
          style: TextStyle(color: bg_down),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            imageUrls.isNotEmpty
                ? Container(
                    height: 200,
                    child: PageView.builder(
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          imageUrls[index],
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                            child: Text('Image not available'),
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
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prediction:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: bg_down)),
                        Text(controller.predictionResult.value),
                        Divider(),
                        Text('Health Risks:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: bg_down)),
                        Text(controller.healthRisks.value),
                      ],
                    )),
              ),
            ),
            SizedBox(height: 16),
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
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
                    Text(controller.formatValue(
                        product.nutriments.extractEnergyKcal(), 'kcal')),
                    SizedBox(height: 8),
                    LinearPercentIndicator(
                      lineHeight: 8,
                      percent: controller.getCaloriesPercent(
                          product.nutriments.extractEnergyKcal()),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                      barRadius: Radius.circular(8),
                    ),
                    Divider(),
                    Text('Nutrients:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: bg_down)),
                    nutrientIndicator(
                      'Fat',
                      product.nutriments.extractFat(),
                      'g',
                      controller.getNutrientPercent(
                          product.nutriments.extractFat(), 100), //70
                    ),
                    nutrientIndicator(
                      'Sugar',
                      product.nutriments.extractSugars(),
                      'g',
                      controller.getNutrientPercent(
                          product.nutriments.extractSugars(), 100), //50
                    ),
                    nutrientIndicator(
                      'Protein',
                      product.nutriments.extractProteins(),
                      'g',
                      controller.getNutrientPercent(
                          product.nutriments.extractProteins(), 100), //50
                    ),
                    nutrientIndicator(
                      'Carbohydrates',
                      product.nutriments.extractCarbohydrates(),
                      'g',
                      controller.getNutrientPercent(
                          product.nutriments.extractCarbohydrates(), 300), //300
                    ),
                    nutrientIndicator(
                      'Fiber',
                      product.nutriments.extractFiber(),
                      'g',
                      controller.getNutrientPercent(
                          product.nutriments.extractFiber(), 100), //30
                    ),
                    nutrientIndicator(
                      'Sodium',
                      product.nutriments.extractSodium(),
                      'mg',
                      controller.getNutrientPercent(
                          product.nutriments.extractSodium(), 2300),
                    ),
                    nutrientIndicator(
                      'Cholesterol',
                      product.nutriments.extractCholesterol(),
                      'mg',
                      controller.getNutrientPercent(
                          product.nutriments.extractCholesterol(), 300),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget nutrientIndicator(
      String label, double? value, String unit, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ${value?.toStringAsFixed(1) ?? 'N/A'} $unit'),
          SizedBox(height: 8),
          LinearPercentIndicator(
            lineHeight: 8,
            percent: percent,
            progressColor: Colors.blue,
            backgroundColor: Colors.grey.shade300,
            barRadius: Radius.circular(8),
          ),
        ],
      ),
    );
  }
}
