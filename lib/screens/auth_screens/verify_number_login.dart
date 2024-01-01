import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoe/api/api_config.dart';
import 'package:zoe/controllers/api_controllers/user_login.dart';
import 'package:zoe/controllers/authentication.dart';
import 'package:zoe/controllers/spinner.dart';
import 'package:zoe/models/login_model.dart';
import 'package:zoe/models/response_model.dart';
import 'package:zoe/screens/home.dart';
import 'package:zoe/themes/app_text_styles.dart';
import 'package:zoe/widgets/authentication/enter_otp.dart';
import 'package:zoe/widgets/core/buttons/primary_button.dart';

class VerifyNumberLoginScreen extends StatefulWidget {
  const VerifyNumberLoginScreen({super.key});

  @override
  State<VerifyNumberLoginScreen> createState() =>
      _VerifyNumberLoginScreenState();
}

class _VerifyNumberLoginScreenState extends State<VerifyNumberLoginScreen> {
  final SpinnerController spinnerController = Get.put(SpinnerController());
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());

  String inputOtp = '';

  void handleOnCompleteInputOtp(value) {
    setState(() {
      inputOtp = value;
    });
  }

  void handleLogin() async {
    try {
      final postData = {"phone": Get.arguments, "otp": inputOtp};
      final response = await dio.post('/account/user/login', data: postData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) {
          return;
        }
        LoginApiResponse resData = LoginApiResponse.fromJson(response.data);
        userController.updateData(resData);
        authController.login();
        Get.offAll(() => const HomeScreen());
      }
    } on DioException catch (e) {
      String errorMessage = '';
      errorMessage = ApiResponse.fromJson(e.response!.data).message;
      if (context.mounted) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(15),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SpinnerController spinnerController = Get.put(SpinnerController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Verify phone number',
              style: AppTextStyle.boldBlack20,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4),
            Text(
              'We have sent a code to (+91${Get.arguments}). Enter it here to verify your identity',
              style: AppTextStyle.regularGrey14,
            ),
            const SizedBox(
              height: 30,
            ),
            EnterOtpFields(handleOnComplete: handleOnCompleteInputOtp),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Resent Code',
                style: AppTextStyle.boldPrimary14,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => PrimaryButton(
                buttonText: 'Confirm',
                onPressedHandler: handleLogin,
                isLoading: spinnerController.isLoading.value)),
          ]),
        ));
  }
}
