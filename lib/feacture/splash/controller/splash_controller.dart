import 'dart:async';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // 4-second delay before moving to Onboard screen
    Timer(const Duration(seconds: 4), () {
      Get.toNamed('/onbored');
    });
  }
}
