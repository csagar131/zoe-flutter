import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoy/api/api_config.dart';
import 'package:zoy/controllers/spinner.dart';
import 'package:zoy/models/response_model.dart';
import 'package:zoy/screens/auth_screens/user_login.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/widgets/authentication/enter_otp.dart';
import 'package:zoy/widgets/core/buttons/primary_button.dart';

class VerifyNumberSignupScreen extends StatefulWidget {
  const VerifyNumberSignupScreen({super.key});

  @override
  State<VerifyNumberSignupScreen> createState() =>
      _VerifyNumberSignupScreenState();
}

class _VerifyNumberSignupScreenState extends State<VerifyNumberSignupScreen> {
  SpinnerController spinnerController = Get.put(SpinnerController());
  String inputOtp = '';

  void handleOnCompleteInputOtp(value) {
    setState(() {
      inputOtp = value;
    });
  }

  void handleVerifyOtp() async {
    spinnerController.toggleSpinner();
    try {
      final postData = {"phone": Get.arguments, "otp": inputOtp};

      final response =
          await dio.post('/account/otp/verify-signup-phone', data: postData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) {
          return;
        }
        Get.to(() => const LoginScreen());
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      errorMessage = ApiResponse.fromJson(e.response!.data).message;

      if (context != null && context.mounted) {
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
    } finally {
      spinnerController.toggleSpinner();
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
                onPressedHandler: handleVerifyOtp,
                isLoading: spinnerController.isLoading.value)),
          ]),
        ));
  }
}
