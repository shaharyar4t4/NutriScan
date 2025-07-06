import 'package:get/get.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  /// Observable fields for UI
  var predictionResult = ''.obs;
  var healthRisks = ''.obs;

  /// Original helpers
  List<String> getImageUrls(Product product) {
    return [
      if (product.imageFrontUrl != null) product.imageFrontUrl!,
      if (product.imageNutritionUrl != null) product.imageNutritionUrl!,
      if (product.imageIngredientsUrl != null) product.imageIngredientsUrl!,
      if (product.imagePackagingUrl != null) product.imagePackagingUrl!,
    ].where((url) => url.isNotEmpty).toList();
  }

  String formatValue(double? value, String unit) {
    if (value == null) {
      return 'N/A';
    } else {
      return '${value.toStringAsFixed(1)} $unit';
    }
  }

  /// ✅ Percent calculation helpers
  double getCaloriesPercent(double? kcal) {
    const dailyCalories = 2000.0;
    return ((kcal ?? 0) / dailyCalories).clamp(0.0, 1.0);
  }

  double getNutrientPercent(double? value, double max) {
    return ((value ?? 0) / max).clamp(0.0, 1.0);
  }

  /// ✅ Call Prediction API
  Future<void> sendToPredictionAPI(Product product) async {
    try {
      final nutriments = product.nutriments;
      if (nutriments == null) {
        predictionResult.value = 'No nutriments available';
        healthRisks.value = 'Unknown';
        return;
      }

      final Map<String, dynamic> payload = {
        "Calories": nutriments.extractEnergyKcal()?.toInt() ?? 0,
        "Protein": nutriments.extractProteins() ?? 0.0,
        "Carbohydrates": nutriments.extractCarbohydrates() ?? 0.0,
        "Fat": nutriments.extractFat() ?? 0.0,
        "Fiber": nutriments.extractFiber() ?? 0.0,
        "Sugars": nutriments.extractSugars() ?? 0.0,
        "Sodium": nutriments.extractSodium()?.toInt() ?? 0,
        "Cholesterol": nutriments.extractCholesterol()?.toInt() ?? 0,
        "Water_Intake": 0,
        "Meal_Type_Dinner": false,
        "Meal_Type_Lunch": true,
        "Meal_Type_Snack": false,
        "Category_Dairy": false,
        "Category_Fruits": false,
        "Category_Grains": false,
        "Category_Meat": false,
        "Category_Snacks": false,
        "Category_Vegetables": false,
      };

      final response = await http.post(
        Uri.parse("http://192.168.1.106:8000/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        predictionResult.value = result['Prediction'] ?? 'N/A';
        healthRisks.value =
            (result['Health Risks'] as List?)?.join(', ') ?? 'None';
      } else {
        predictionResult.value = 'API failed: ${response.statusCode}';
        healthRisks.value = 'No data';
      }
    } catch (e) {
      predictionResult.value = 'Error: $e';
      healthRisks.value = 'Error';
    }
  }
}

/// ✅ Safe extract extension same as before...
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

  double? extractFiber() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['fiber_serving']) ??
        _parseToDouble(map['fiber_100g']) ??
        _parseToDouble(map['fiber']);
  }

  double? extractSodium() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['sodium_serving']) ??
        _parseToDouble(map['sodium_100g']) ??
        _parseToDouble(map['sodium']);
  }

  double? extractCholesterol() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['cholesterol_serving']) ??
        _parseToDouble(map['cholesterol_100g']) ??
        _parseToDouble(map['cholesterol']);
  }

  double? extractCarbohydrates() {
    if (this == null) return null;
    final map = this!.toJson();
    return _parseToDouble(map['carbohydrates_serving']) ??
        _parseToDouble(map['carbohydrates_100g']) ??
        _parseToDouble(map['carbohydrates']);
  }
}

double? _parseToDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
