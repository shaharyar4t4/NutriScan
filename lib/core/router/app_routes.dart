import 'package:get/get.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onboredcar.dart';

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
  )
];
