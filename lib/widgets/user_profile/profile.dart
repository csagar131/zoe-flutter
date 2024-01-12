import 'package:flutter/material.dart';
import 'package:zoy/themes/app_text_styles.dart';

class Profile extends StatelessWidget {
  final String firstName;
  final String gender;
  final int age;

  const Profile(
      {super.key,
      required this.firstName,
      required this.age,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(55))),
            child: Stack(
              children: [
                ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: Material(
                    child: Ink.image(
                      width: 108,
                      height: 108,
                      fit: BoxFit.cover,
                      image: const NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSay_7Jv-aXnExUdMP8aAG66UIiGzbjm_3p3w&usqp=CAU'),
                    ),
                  ),
                ),
                // const Positioned(
                //     top: 80, left: 80, child: Icon(Icons.edit_square)),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                firstName.toUpperCase(),
                style: AppTextStyle.boldBlack20,
              ),
              Text(
                '$age,$gender',
                style: AppTextStyle.boldGrey14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
