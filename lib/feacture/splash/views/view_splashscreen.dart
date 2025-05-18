import 'dart:async';

import 'package:flutter/material.dart';

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
        // backgroundColor: ,
        );
  }
}
