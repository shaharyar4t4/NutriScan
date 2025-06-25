import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';

class ViewLoginscreen extends StatefulWidget {
  const ViewLoginscreen({super.key});

  @override
  State<ViewLoginscreen> createState() => _ViewLoginscreenState();
}

class _ViewLoginscreenState extends State<ViewLoginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
