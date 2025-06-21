import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';

class ViewSplashscreen extends StatefulWidget {
  const ViewSplashscreen({super.key});

  @override
  State<ViewSplashscreen> createState() => _ViewSplashscreenState();
}

class _ViewSplashscreenState extends State<ViewSplashscreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bg_up,
              bg_down,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/bg_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Centered logo
            Center(
              child: Image.asset(
                'assets/images/main_log.png',
                width: 250,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
