import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zoe/screens/home.dart';
import 'package:zoe/screens/auth_screens/user_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();

  bool userLoggedIn = false;

  @override
  void initState() {
    super.initState();

    if (storage.hasData('isLoggedIn') == false) {
      storage.write('isLoggedIn', false);
    }

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => storage.read('isLoggedIn')
                    ? const HomeScreen()
                    : const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Image.network(
        'https://cdn-icons-png.flaticon.com/128/5683/5683167.png?ga=GA1.1.167434193.1702374194&semt=ais',
        fit: BoxFit.none,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
