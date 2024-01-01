import 'package:flutter/material.dart';
import 'package:zoe/themes/app_text_styles.dart';

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
                  width: 2,
                  color: Colors.blue,
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
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRch6CDHA9hqbe3GbIo6O0T-EWeIL7JJ8_cpQ&usqp=CAU'),
                    ),
                  ),
                ),
                const Positioned(
                    top: 80, left: 80, child: Icon(Icons.edit_square)),
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
                firstName,
                style: AppTextStyle.boldBlack16,
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
