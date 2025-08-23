import '../constants/app_linker.dart';

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
