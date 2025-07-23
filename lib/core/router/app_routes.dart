import 'package:get/get.dart';
import 'package:nutriscan/feacture/auth/view/view_loginscreen.dart';
import 'package:nutriscan/feacture/auth/view/view_signupscreen.dart';
import 'package:nutriscan/feacture/barcode/home_screen/view_home_screen.dart';
import 'package:nutriscan/feacture/navigation_bar/nav_bar_ui/nav_bar_ui.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onboredcar.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onboredscreen.dart';
import 'package:nutriscan/feacture/profile/view/view_profilescreen.dart';
import 'package:nutriscan/feacture/recent_product/view/view_scan_history_screen.dart';

var allPage = [
  GetPage(
    name: '/onbored',
    page: () => ViewOnboardCar(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/onboredscreen',
    page: () => ViewOnboredscreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/loginScreen',
    page: () => ViewLoginScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/signupScreen',
    page: () => ViewSignUpScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/navbar',
    page: () => NavBar(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/profileview',
    page: () => ProfileScreen(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/scanHistory',
    page: () => ScanHistoryScreen(),
    transition: Transition.cupertino,
  ),
];
