import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart' as getx;
import 'package:zoy/controllers/api_controllers/file_upload.dart';
import 'package:zoy/controllers/api_controllers/user_login.dart';
import 'package:zoy/controllers/spinner.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/widgets/core/userinput/custom_date_picker.dart';
import 'package:zoy/widgets/core/userinput/custom_dropdown.dart';
import 'package:zoy/widgets/core/userinput/custom_image_picker.dart';
import 'package:zoy/widgets/core/userinput/custom_text_input.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController userController = getx.Get.put(UserController());
  SpinnerController spinnerController = getx.Get.put(SpinnerController());
  FileUploadApiController fileUploadApiController = FileUploadApiController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    void editProfile() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (formKey.currentState?.value['image'] == null) {
          return;
        }
        File file = File(formKey.currentState?.value['image'][0]?.path);
        // Call the uploadFile method from the ApiController
        await fileUploadApiController.uploadFile(file);
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              editProfile();
            },
            icon: const Icon(
              Icons.done,
            ),
          )
        ],
        title: Text(
          'Edit Profile',
          style: AppTextStyle.boldPrimary18,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  const CustomImagePicker(name: 'image'),
                  const SizedBox(
                    height: 20,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'First Name',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeTextInput(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      validator: FormBuilderValidators.compose([
                        /// Makes this field required
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(20),
                      ]),
                      name: 'first_name',
                      initialValue: userController
                          .loginApiResponse.data.profile.firstName,
                      prefix: ''),
                  const SizedBox(
                    height: 10,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'Last Name',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeTextInput(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      validator: FormBuilderValidators.compose([
                        /// Makes this field required
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(20),
                      ]),
                      name: 'last_name',
                      initialValue:
                          userController.loginApiResponse.data.profile.lastName,
                      prefix: ''),
                  const SizedBox(height: 10),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'Mobile',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeTextInput(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      validator: FormBuilderValidators.compose([
                        /// Makes this field required
                        FormBuilderValidators.required(),

                        // Include your own custom `FormFieldValidator` function, if you want
                        // Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
                        (val) {
                          final number = int.tryParse(val! as String);
                          if (number == null) {
                            return 'This field cannot be empty';
                          }
                          if (number <= 0) {
                            return 'We cannot have a negative or 0 qty';
                          }
                          return null;
                        },
                      ]),
                      name: 'phone',
                      initialValue:
                          userController.loginApiResponse.data.user.phone,
                      prefix: ''),
                  const SizedBox(
                    height: 14,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'Email',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeTextInput(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      validator: FormBuilderValidators.compose([
                        /// Makes this field required
                        FormBuilderValidators.email(),
                        FormBuilderValidators.required()
                      ]),
                      name: 'email',
                      initialValue:
                          userController.loginApiResponse.data.profile.email,
                      prefix: ''),
                  const SizedBox(
                    height: 14,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'DOB',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeDatePicker(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      validator: FormBuilderValidators.compose([
                        /// Makes this field required
                        FormBuilderValidators.required(),
                      ]),
                      name: 'dob',
                      initialValue: DateTime.parse(
                          userController.loginApiResponse.data.profile.dob)),
                  const SizedBox(height: 14),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        'Gender',
                        style: AppTextStyle.boldGrey12,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  CustomeDropdown(
                      textStyle:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      name: 'gender',
                      initialValue:
                          userController.loginApiResponse.data.profile.gender,
                      itemList: const [
                        {'label': 'Male', 'value': 'MALE'},
                        {'label': 'Female', 'value': 'FEMALE'}
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
