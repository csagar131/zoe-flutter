import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoy/controllers/api_controllers/request_controller.dart';
import 'package:zoy/controllers/api_controllers/user_login.dart';
import 'package:zoy/controllers/authentication.dart';
import 'package:zoy/controllers/spinner.dart';
import 'package:zoy/models/login_model.dart';
import 'package:zoy/screens/home.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/widgets/authentication/enter_otp.dart';
import 'package:zoy/widgets/core/buttons/primary_button.dart';

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
  ApiRequestController apiRequestController = ApiRequestController();

  String inputOtp = '';

  void handleOnCompleteInputOtp(value) {
    setState(() {
      inputOtp = value;
    });
  }

  void handleLogin() async {
    await apiRequestController.handleApiRequest(
        endpoint: '/account/user/login',
        token: '',
        method: HttpMethod.post,
        successCallback: (dynamic response) {
          userController.updateData(LoginApiResponse.fromJson(response.data));
          authController.login();
          Get.offAll(() => const HomeScreen());
        },
        showSpinner: true,
        data: {"phone": Get.arguments, "otp": inputOtp});
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
