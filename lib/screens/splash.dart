import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zoy/screens/home.dart';
import 'package:zoy/screens/auth_screens/user_login.dart';
import 'package:zoy/themes/app_text_styles.dart';

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
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFFFF5BB8), Color(0xFF6E003F)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_icon.png',
                width: 50,
                height: 50,
              ),
              Text(
                'Zoy',
                style: AppTextStyle.boldWhite16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
