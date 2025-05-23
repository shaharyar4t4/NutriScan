import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';

class ViewSplashscreen extends StatefulWidget {
  const ViewSplashscreen({super.key});

  @override
  State<ViewSplashscreen> createState() => _ViewSplashscreenState();
}

class _ViewSplashscreenState extends State<ViewSplashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bg_up, // Starting color
              bg_down, // Ending color
            ],
          ),
        ),
        child: Center(
            child: Stack(children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_image.png'),
                  opacity: 0.5),
            ),
          ),
          Positioned(
            top: 220,
            left: 26,
            child: Center(
                child: Image.asset(
              'assets/images/main_log.png',
              width: 300,
              height: 300,
            )),
          ),
        ])),
      ),
    );
  }
}
