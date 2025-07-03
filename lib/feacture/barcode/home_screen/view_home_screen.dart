import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/auth/services/auth_services.dart';
import 'package:nutriscan/feacture/barcode/home_screen/barcode_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _barcode;
  bool _isLoading = false;
  String? fullName;
  final AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  void fetchName() async {
    final name = await _auth.getUserName();
    setState(() {
      fullName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: deviceHeight * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  bg_up,
                  bg_down,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(deviceWidth * 0.1),
                bottomRight: Radius.circular(deviceWidth * 0.1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
                vertical: deviceHeight * 0.05,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: deviceWidth * 0.1,
                        height: deviceWidth * 0.1,
                        decoration: BoxDecoration(
                          color: icon_bg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.menu,
                            color: Colors.white, size: deviceWidth * 0.07),
                      ),
                      Image.asset(
                        'assets/images/main_log.png',
                        width: deviceWidth * 0.25,
                        height: deviceWidth * 0.25,
                      ),
                      Container(
                        width: deviceWidth * 0.1,
                        height: deviceWidth * 0.1,
                        decoration: BoxDecoration(
                          color: icon_bg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(CupertinoIcons.bell,
                            color: Colors.white, size: deviceWidth * 0.07),
                      ),
                    ],
                  ),
                  SizedBox(height: deviceHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName != null ? 'Hi, $fullName!' : 'Hi, User!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: deviceHeight * 0.02),
          Padding(
            padding: EdgeInsets.all(deviceWidth * 0.02),
            child: Container(
              height: deviceHeight * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: card_bg,
                borderRadius: BorderRadius.circular(deviceWidth * 0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.05),
                          child: Text(
                            "Scan a Product",
                            style: TextStyle(
                              fontSize: deviceWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: deviceHeight * 0.01),
                        ElevatedButton.icon(
                          onPressed: () {
                            BarcodeService.scanBarcode(
                              context: context,
                              onBarcodeScanned: (barcode) {
                                setState(() {
                                  _barcode = barcode;
                                });
                              },
                              onLoading: (isLoading) {
                                setState(() {
                                  _isLoading = isLoading;
                                });
                              },
                            );
                          },
                          icon: Icon(Icons.qr_code_scanner,
                              color: Colors.white, size: deviceWidth * 0.06),
                          label: Text(
                            "Scan Now",
                            style: TextStyle(fontSize: deviceWidth * 0.045),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bg_down,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.05,
                              vertical: deviceHeight * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        Positioned(
                          top: deviceHeight * 0.01,
                          left: deviceWidth * 0.02,
                          child: Image.asset(
                            'assets/images/bgcardicon.png',
                            fit: BoxFit.cover,
                            width: deviceWidth * 0.25,
                          ),
                        ),
                        Image.asset(
                          'assets/images/bgcardper.png',
                          fit: BoxFit.cover,
                          width: deviceWidth * 0.25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
