import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zoy/api/api_config.dart';
import 'package:zoy/controllers/api_controllers/user_login.dart';
import 'package:zoy/controllers/spinner.dart';

class FileUploadApiController extends GetxController {
  final UserController userController = getx.Get.put(UserController());
  SpinnerController spinnerController = getx.Get.put(SpinnerController());

  Future<void> uploadFile(File file) async {
    try {
      spinnerController.toggleSpinner();
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: 'image.jpg',
        ),
      });

      final response = await dio.post(
        '/account/files/upload-file',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization':
                'Token ${userController.loginApiResponse.data.token.toString()}',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        getx.Get.snackbar(
          'Success',
          'Profile Update Successfully',
          snackPosition: getx.SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(15),
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';

      // Handle specific error messages if needed
      if (e.response != null && e.response!.data != null) {
        errorMessage =
            e.response!.data['data'].entries.map((e) => e.value[0]).toList()[0];
      }

      getx.Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: getx.SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 2000),
        margin: const EdgeInsets.all(15),
      );
    } finally {
      // You may want to perform any cleanup or post-request actions here
      spinnerController.toggleSpinner();
    }
  }
}
