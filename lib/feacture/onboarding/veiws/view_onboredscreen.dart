import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/onboarding/controller/onboredscreen_controller.dart';

class ViewOnboredscreen extends StatelessWidget {
  ViewOnboredscreen({super.key});

  final OnBoardScreenController controller = Get.put(OnBoardScreenController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bg_up, bg_down],
              ),
            ),
          ),

          // 2. Light Pattern Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/images/bg_image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 3. Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/main_log.png',
                  height: 60,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Ready to Start\nScan Products?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Tap below to make your account &\nstart scanning products.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.goToHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Bottom Background Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/backfinal_onbri.png',
              height: size.height * 0.50,
              fit: BoxFit.cover,
            ),
          ),

          // 5. Foreground Image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/final_onbro.png',
              height: size.height * 0.50,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
