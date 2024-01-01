import 'package:flutter/material.dart';
import 'package:zoe/themes/app_text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final String btnText;
  final Function onClickHandler;

  const SecondaryButton(
      {super.key, required this.btnText, required this.onClickHandler});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white70), // Set the background color
        foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white), // Set the font color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      onPressed: () {
        onClickHandler();
      },
      child: Text(
        btnText,
        style: AppTextStyle.mediumBlack14,
      ),
    );
  }
}
