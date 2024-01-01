import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zoe/api/api_config.dart';
import 'package:zoe/controllers/spinner.dart';
import 'package:zoe/models/response_model.dart';
import 'package:zoe/screens/auth_screens/user_signup.dart';
import 'package:zoe/screens/auth_screens/verify_number_login.dart';
import 'package:zoe/themes/app_text_styles.dart';
import 'package:zoe/widgets/core/buttons/primary_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic phoneInputError;

  String inputNumber = '';

  SpinnerController spinnerController = Get.put(SpinnerController());

  dynamic validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) {
      setState(() {
        phoneInputError = 'Mobile Number must be of 10 digit';
      });
      return 'Mobile Number must be of 10 digit';
    } else {
      setState(() {
        phoneInputError = null;
      });
      return null;
    }
  }

  void handleUserLogin() async {
    if (validateMobile(inputNumber) == null) {
      try {
        spinnerController.toggleSpinner();
        final postData = {
          "phone": inputNumber,
        };

        if (!context.mounted) {
          return;
        }

        final response =
            await dio.post('/account/user/pre-login', data: postData);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.to(() => const VerifyNumberLoginScreen(), arguments: inputNumber);
        }
      } on DioException catch (e) {
        String errorMessage = 'An error occurred';

        if (e.response?.statusCode != 404 && e.response?.statusCode != 500) {
          errorMessage = ApiResponse.fromJson(e.response!.data).message;
        }

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
      } finally {
        spinnerController.toggleSpinner();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                      'https://img.freepik.com/premium-photo/man-woman-sit-couch-with-hearts-heart-wall_863013-90793.jpg?w=1060'))),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: AppTextStyle.boldBlack26,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Sign in to your account',
                              style: AppTextStyle.regularGrey18,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              onChanged: (value) {
                                inputNumber = value;
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 10),
                                    child: Text(
                                      '+91',
                                      style: AppTextStyle.boldBlack14,
                                    )),
                                label: const Text('Enter Phone Number'),
                                // prefix: const Icon(Icons.phone_callback),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  phoneInputError ?? '',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Obx(
                              () => PrimaryButton(
                                  isLoading: spinnerController.isLoading.value,
                                  buttonText: 'Continue',
                                  onPressedHandler: handleUserLogin),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dont have account? '),
                              InkWell(
                                onTap: () => Get.to(() => const SignUpScreen()),
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyle.regularPrimary14,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
