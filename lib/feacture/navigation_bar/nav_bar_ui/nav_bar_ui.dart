import 'package:nutriscan/core/constants/app_linker.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late NavBarController controller;

  final List<Widget> pages = [
    HomeScreen(),
    ScanHistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = NavBarController(vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 0.1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: pages[controller.selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex,
          onTap: controller.onItemTapped,
          selectedItemColor: bg_down,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: bg_down),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            _buildNavItem(Icons.home, 'Home'),
            _buildNavItem(Icons.history, 'History'),
          ],
          selectedIconTheme: IconThemeData(color: bg_down, size: 28),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 24),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: ScaleTransition(
        scale: controller.animation,
        child: Icon(icon, size: 22),
      ),
      label: label,
      backgroundColor: card_bg,
    );
  }
}
