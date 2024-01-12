import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:zoy/themes/app_colors.dart';

class CustomeDatePicker extends StatelessWidget {
  final TextStyle textStyle;
  final dynamic validator;
  final String name;
  final DateTime initialValue;

  const CustomeDatePicker({
    super.key,
    required this.textStyle,
    required this.validator,
    required this.name,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: FormBuilderDateTimePicker(
        inputType: InputType.date,
        initialValue: initialValue,
        style: textStyle,
        name: name,
        validator: validator,
        decoration: InputDecoration(
          fillColor: AppColors.bgColor, // Change this to your desired color
          filled: true,

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
