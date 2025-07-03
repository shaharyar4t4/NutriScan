import 'package:openfoodfacts/openfoodfacts.dart';

class ProductController {
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
}

// Extension for safer nutrient extraction
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
