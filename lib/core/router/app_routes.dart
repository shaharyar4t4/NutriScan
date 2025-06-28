import 'package:get/get.dart';
import 'package:nutriscan/feacture/auth/view/view_loginscreen.dart';
import 'package:nutriscan/feacture/auth/view/view_signupscreen.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onboredcar.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onboredscreen.dart';

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
  )
];
