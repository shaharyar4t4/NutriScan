import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/auth/services/auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices _authServices = AuthServices();

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Map<String, String>>(
          future: _authServices.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        'Profile Details',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: bg_up),
                      ),
                      const SizedBox(height: 20),
                      Text("Hi, ${userData['name']}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 20),
                      Text("Email: ${userData['email']}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 35),
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/detail');
                        },
                        icon: const Icon(
                          Icons.info_outline,
                          color: bg_up,
                        ),
                        label: const Text(
                          'Detail',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black, // text + icon color
                        ),
                      ),
                      const SizedBox(height: 13),
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/about');
                        },
                        icon: const Icon(
                          Icons.people_outline,
                          color: bg_up,
                          size: 18,
                        ),
                        label: const Text(
                          'About Us',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 13),
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/tips');
                        },
                        icon: const Icon(Icons.lightbulb_outline, color: bg_up),
                        label: const Text(
                          'Tips',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _authServices.logout();
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        icon: const Icon(Icons.logout, size: 24), // Icon
                        label: const Text("Log out"), // Text
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, // text/icon color
                          backgroundColor: bg_up, // your bg color variable
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Text('No Data');
            }
          },
        ),
      ),
    );
  }
}
