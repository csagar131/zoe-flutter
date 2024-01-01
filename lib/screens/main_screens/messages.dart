import 'package:flutter/material.dart';
import 'package:zoe/themes/app_text_styles.dart';
import 'package:zoe/widgets/core/buttons/secondary_button.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXwEz4YODxzNr123z4w8B9vG-3GIwlIpQZqg&usqp=CAU',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "You're new here! No matches yet.",
                  style: AppTextStyle.boldBlack14,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '"When a like turns into a connection, you can chat here."',
                  style: AppTextStyle.boldGrey12,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                    btnText: 'Try boosting your profile', onClickHandler: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
