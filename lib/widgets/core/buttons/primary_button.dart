import 'package:flutter/material.dart';
import 'package:zoy/themes/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.buttonText,
      required this.onPressedHandler,
      required this.isLoading});

  final bool isLoading;
  final Function onPressedHandler;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary), // Set the background color
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
        onPressedHandler();
      },
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              buttonText,
              style: AppTextStyle.regularWhite16,
            ),
    );
  }
}
