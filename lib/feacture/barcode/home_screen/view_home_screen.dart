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
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: icon_bg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.menu, color: Colors.white, size: 30),
                      ),
                      Image.asset(
                        'assets/images/main_log.png',
                        width: 90,
                        height: 90,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: icon_bg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(CupertinoIcons.bell,
                            color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName != null ? 'Hi, $fullName!' : 'Hi, User!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: card_bg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Scan a Product",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 7),
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
                        icon: Icon(Icons.barcode_reader,
                            color: Colors.white, size: 24),
                        label: Text("Scan Now"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bg_down, // green button color
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      // if (_barcode != null) Text('Last Scanned: $_barcode'),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Image.asset(
                          'assets/images/bgcardicon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Image.asset(
                        'assets/images/bgcardper.png',
                        fit: BoxFit.cover,
                      ),
                    ],
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
