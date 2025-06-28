import 'dart:async';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // 3-second delay before moving to onbored screen
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/onbored');
    });
  }
}
