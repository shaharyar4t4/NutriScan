import 'package:nutriscan/core/constants/app_linker.dart';

class ProfileController {
  final AuthServices _authServices = AuthServices();

  Future<Map<String, String>> getUserData() {
    return _authServices.getUserData();
  }

  Future<void> logout() {
    return _authServices.logout();
  }
}
