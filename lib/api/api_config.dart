import 'package:dio/dio.dart';

final dio = Dio();

void configureDio() {
  dio.options.baseUrl = 'https://smart-porpoise-conversely.ngrok-free.app/';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
}
