import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class EnterOtpFields extends StatelessWidget {
  EnterOtpFields({super.key, required this.handleOnComplete});

  final Function handleOnComplete;

  static final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      length: 6,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      keyboardType: TextInputType.number,
      onCompleted: (pin) {
        handleOnComplete(pin);
      },
    );
  }
}
