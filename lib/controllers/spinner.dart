import 'package:get/get.dart';

class SpinnerController extends GetxController {
  RxBool isLoading = false.obs;

  toggleSpinner() {
    isLoading.toggle();
  }
}
