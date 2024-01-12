import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoy/api/api_config.dart';
import 'package:zoy/controllers/spinner.dart';

class ApiRequestController {
  Future<void> handleApiRequest(
      {required String endpoint,
      Map<String, dynamic>? data,
      required String token,
      required HttpMethod method,
      required Function successCallback,
      BuildContext? context,
      required bool showSpinner}) async {
    try {
      if (showSpinner) {
        Get.find<SpinnerController>().toggleSpinner();
      }

      dynamic response;

      // ApiResponse response;

      switch (method) {
        case HttpMethod.get:
          response = await dio.get(
            endpoint,
            options: Options(
              headers:
                  token.isNotEmpty ? {'Authorization': 'Token $token'} : {},
            ),
          );
          break;
        case HttpMethod.post:
          response = await dio.post(
            endpoint,
            data: json.encode(data),
            options: Options(
              headers:
                  token.isNotEmpty ? {'Authorization': 'Token $token'} : {},
            ),
          );
          break;
        case HttpMethod.patch:
          response = await dio.patch(
            endpoint,
            data: json.encode(data),
            options: Options(headers: {'Authorization': 'Token $token'}),
          );
          break;
        // Add cases for other HTTP methods if needed

        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        successCallback(response);
        return response;
      }
    } on DioException catch (e) {
      String errorMessage = e.toString();
      // errorMessage = ApiResponse.fromJson(e.response!.data).message;
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
      if (showSpinner) {
        Get.find<SpinnerController>().toggleSpinner();
      }
    }
  }
}

enum HttpMethod { get, post, patch }  // Add more methods if needed
