import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:zoy/controllers/api_controllers/request_controller.dart';
import 'package:zoy/controllers/spinner.dart';
import 'package:zoy/screens/auth_screens/user_login.dart';
import 'package:zoy/screens/auth_screens/verify_number_signup.dart';
import 'package:zoy/themes/app_colors.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/widgets/core/buttons/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    SpinnerController spinnerController = Get.put(SpinnerController());

    ApiRequestController apiRequestController = ApiRequestController();

    void createAccount() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await apiRequestController.handleApiRequest(
            endpoint: '/account/user/signup',
            token: '',
            method: HttpMethod.post,
            successCallback: (dynamic response) => Get.to(
                () => const VerifyNumberSignupScreen(),
                arguments: formKey.currentState?.value['phone']),
            showSpinner: true,
            data: {
              'first_name': formKey.currentState?.value['first_name'],
              'last_name': formKey.currentState?.value['last_name'],
              'gender': formKey.currentState?.value['gender'],
              // 'dob': formKey.currentState?.value['dob'].value,
              'dob': '1998-04-02',
              'email': formKey.currentState?.value['email'],
              'phone': formKey.currentState?.value['phone']
            });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: FormBuilder(
                key: formKey,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://img.freepik.com/premium-photo/man-woman-sit-couch-with-hearts-heart-wall_863013-90793.jpg?w=1060'))),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Welcome!',
                            style: AppTextStyle.boldBlack26,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Create your account',
                            style: AppTextStyle.regularGrey18,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FormBuilderTextField(
                            name: 'first_name',
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              /// Makes this field required
                              FormBuilderValidators.required(),

                              FormBuilderValidators.max(20),
                            ]),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          FormBuilderTextField(
                            name: 'last_name',
                            validator: FormBuilderValidators.compose([
                              /// Makes this field required
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              focusedErrorBorder: OutlineInputBorder(
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
                            ),
                          ),
                          const SizedBox(height: 14),
                          FormBuilderTextField(
                            name: 'phone',
                            validator: FormBuilderValidators.compose([
                              /// Makes this field required
                              FormBuilderValidators.required(),

                              // Include your own custom `FormFieldValidator` function, if you want
                              // Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
                              (val) {
                                final number = int.tryParse(val!);
                                if (number == null) {
                                  return 'This field cannot be empty';
                                }
                                if (number <= 0) {
                                  return 'We cannot have a negative or 0 qty';
                                }
                                return null;
                              },
                            ]),
                            decoration: InputDecoration(
                              prefix: const Text('+91'),
                              labelText: 'Phone Number',
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          FormBuilderTextField(
                            name: 'email',
                            validator: FormBuilderValidators.compose([
                              /// Makes this field required
                              FormBuilderValidators.email(),
                              FormBuilderValidators.required()
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          FormBuilderDateTimePicker(
                            inputType: InputType.date,
                            lastDate: DateTime.now(),
                            name: 'dob',
                            validator: FormBuilderValidators.compose([
                              /// Makes this field required
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'Date of birth',
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          FormBuilderDropdown(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
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
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              name: 'gender',
                              items: [
                                ...[
                                  {'name': 'Male', 'value': 'MALE'},
                                  {'name': 'Female', 'value': 'FEMALE'}
                                ].map((e) => DropdownMenuItem(
                                    value: e['value'],
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 14,
                                          height: 14,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(e['name']!),
                                      ],
                                    )))
                              ],
                              onChanged: (value) {}),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => PrimaryButton(
                              onPressedHandler: createAccount,
                              isLoading: spinnerController.isLoading.value,
                              buttonText: 'Create Account',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have  account? '),
                              InkWell(
                                onTap: () => Get.to(() => const LoginScreen()),
                                child: Text(
                                  'Sign in',
                                  style: AppTextStyle.regularPrimary14,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
