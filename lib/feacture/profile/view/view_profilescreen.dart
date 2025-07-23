import 'package:flutter/material.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = ProfileController();

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Map<String, String>>(
          future: controller.getUserData(),
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
                      const SizedBox(height: 45),
                      Text(
                        'Profile Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: bg_up,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Hi, ${userData['name']}",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Email: ${userData['email']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35),

                      // Detail Button
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/detail');
                        },
                        icon: const Icon(Icons.info_outline, color: bg_up),
                        label: const Text(
                          'Detail',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 13),

                      // About Us Button
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/about');
                        },
                        icon: const Icon(Icons.people_outline,
                            color: bg_up, size: 18),
                        label: const Text(
                          'About Us',
                          style: TextStyle(fontSize: 15),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 13),

                      // Tips Button
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

                  // Logout Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await controller.logout();
                          Navigator.of(context)
                              .pushReplacementNamed('/loginScreen');
                        },
                        icon: const Icon(Icons.logout, size: 24),
                        label: const Text("Log out"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: bg_up,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 10,
                          ),
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
