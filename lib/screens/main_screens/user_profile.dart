import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoy/controllers/api_controllers/user_login.dart';
import 'package:zoy/controllers/authentication.dart';
import 'package:zoy/screens/auth_screens/user_login.dart';
import 'package:zoy/screens/edit_profile.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/utils/local_storage.dart';
import 'package:zoy/widgets/core/buttons/secondary_button.dart';
import 'package:zoy/widgets/user_profile/plan_card.dart';
import 'package:zoy/widgets/user_profile/profile.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final AuthController _authController = Get.put(AuthController());

  final UserController userController = Get.put(UserController());

  void onLogout() {
    _authController.logout();
    clearData();
    Get.to(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
            ),
            onPressed: () {
              Get.to(() => const EditProfileScreen());
            },
          )
        ],
        title: Text(
          'Profile',
          style: AppTextStyle.boldPrimary18,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Center(
              child: ListView(
            children: [
              Profile(
                firstName:
                    userController.loginApiResponse.data.profile.firstName,
                age: userController.loginApiResponse.data.profile.age,
                gender: userController.loginApiResponse.data.profile.gender,
              ),
              const SizedBox(
                height: 10,
              ),
              const PlanCard(),
              const SizedBox(
                height: 30,
              ),
              SecondaryButton(
                btnText: 'Logout',
                onClickHandler: onLogout,
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Delete account',
                style: AppTextStyle.boldBlack14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Text(
                    'zoy',
                    style: AppTextStyle.boldGrey18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Version 1',
                    style: AppTextStyle.mediumGrey12,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Made in India',
                        style: AppTextStyle.mediumGrey12,
                      ),
                      const Icon(
                        Icons.favorite,
                        size: 15,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
