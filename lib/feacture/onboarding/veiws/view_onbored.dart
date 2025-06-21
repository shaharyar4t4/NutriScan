import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';

class VeiwOnbroad extends StatefulWidget {
  const VeiwOnbroad({super.key});

  @override
  State<VeiwOnbroad> createState() => _VeiwOnbroadState();
}

class _VeiwOnbroadState extends State<VeiwOnbroad> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<String> titles = [
    "Your pocket guide to healthier choices.",
    "Scan & Discover Product Details",
  ];

  final List<String> descriptions = [
    "Track your journey towards healthier choices with your personal scan history.",
    "Scan any food or cosmetic product to instantly reveal its health impact.",
  ];

  final List<String> images = [
    "assets/images/onbro_one.png",
    "assets/images/onbro_two.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Background Image
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),

              // Skip button
              Positioned(
                top: 50,
                right: 20,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/home'),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Bottom overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          titles.length,
                          (dotIndex) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == dotIndex
                                  ? bg_up
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Description
                      Text(
                        descriptions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Next / Get Started Button
                      ElevatedButton(
                        onPressed: () {
                          if (currentIndex == titles.length - 1) {
                            Get.toNamed('/home');
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bg_up,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Next",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(Icons.arrow_forward,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
