import 'package:get/get.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';
import 'package:nutriscan/feacture/onboarding/veiws/view_onbored.dart';

var allPage = [
  GetPage(
    name: '/onbored',
    page: () => VeiwOnbroad(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    transition: Transition.cupertino,
  )
];
