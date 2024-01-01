import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  final storage = GetStorage();

  login() {
    isLoggedIn.value = true;
    storage.write('isLoggedIn', true);
  }

  logout() {
    storage.write('isLoggedIn', false);
    isLoggedIn.value = false;
  }
}
