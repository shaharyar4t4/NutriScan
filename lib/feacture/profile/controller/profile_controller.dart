import 'package:nutriscan/feacture/auth/services/auth_services.dart';

class ProfileController {
  final AuthServices _authServices = AuthServices();

  Future<Map<String, String>> getUserData() {
    return _authServices.getUserData();
  }

  Future<void> logout() {
    return _authServices.logout();
  }
}
