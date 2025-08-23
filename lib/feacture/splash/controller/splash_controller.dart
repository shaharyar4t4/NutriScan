import 'package:nutriscan/core/constants/app_linker.dart';

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
