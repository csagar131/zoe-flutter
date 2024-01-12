import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:zoy/themes/app_colors.dart';

class CustomeTextInput extends StatelessWidget {
  final TextStyle textStyle;
  final dynamic validator;
  final String name;
  final String initialValue;
  final String prefix;

  const CustomeTextInput(
      {super.key,
      required this.textStyle,
      required this.validator,
      required this.name,
      required this.initialValue,
      required this.prefix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: FormBuilderTextField(
        initialValue: initialValue,
        // style: const TextStyle(fontSize: 14.0, color: Colors.black),
        style: textStyle,
        name: name,
        validator: validator,
        decoration: InputDecoration(
          fillColor: AppColors.bgColor, // Change this to your desired color
          filled: true,
          prefix: Text(prefix),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
