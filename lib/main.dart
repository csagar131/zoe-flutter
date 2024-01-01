import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:zoe/api/api_config.dart';
import 'package:zoe/screens/splash.dart';
import 'package:zoe/themes/theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    configureDio();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
