import 'package:nutriscan/core/constants/app_linker.dart';

class OnboardCarController extends GetxController {
  final PageController pageController = PageController();
  var currentIndex = 0.obs;

  final titles = [
    "Your pocket guide to healthier choices.",
    "Scan & Discover Product Details",
    "Clear Health Scores With Our AI",
  ];

  final descriptions = [
    "Track your journey towards healthier choices with your personal scan history.",
    "Scan any food or cosmetic product to instantly reveal its health impact.",
    "Get straightforward health scores based on ingredients and quality."
  ];

  final images = [
    "assets/images/onbro_one.png",
    "assets/images/onbro_two.png",
    "assets/images/onbro_three.png",
  ];

  void nextPage() {
    if (currentIndex.value == titles.length - 1) {
      Get.toNamed('/onboredscreen');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    Get.offAllNamed('/loginScreen');
  }

  void updatePageIndex(int index) {
    currentIndex.value = index;
  }
}
