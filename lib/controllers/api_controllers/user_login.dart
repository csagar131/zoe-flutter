import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zoy/models/login_model.dart';

class UserController extends GetxController {
  final _loginApiResponse = LoginApiResponse(
    message: '',
    data: UserData(
      user: User(phone: '', lastLogin: DateTime.now()),
      token: '',
      profile: Profile(
        uuid: '',
        firstName: '',
        lastName: '',
        email: '',
        dob: '',
        age: 0,
        gender: '',
        minRadius: 0,
        maxRadius: 0,
        currentCity: '',
        country: '',
        countryCode: '',
        latitude: 0.0,
        longitude: 0.0,
        isPhoneVerified: false,
        isEmailVerified: false,
        createdAt: '',
        updatedAt: '',
      ),
    ),
  ).obs;

  LoginApiResponse get loginApiResponse => _loginApiResponse.value;

  @override
  void onInit() {
    super.onInit();
    _loadDataFromStorage();
  }

  // Save data to local storage
  void saveDataToLocal() {
    GetStorage().write('userDetails', _loginApiResponse.value.toJson());
  }

  // Load data from local storage
  void _loadDataFromStorage() {
    if (GetStorage().hasData('userDetails')) {
      final savedData = GetStorage().read('userDetails');
      if (savedData != null) {
        _loginApiResponse.value = LoginApiResponse.fromJson(savedData);
        return;
      }
    }
  }

  // Update data in the controller and local storage
  void updateData(LoginApiResponse newData) {
    _loginApiResponse.value = newData;
    saveDataToLocal();
  }
}
