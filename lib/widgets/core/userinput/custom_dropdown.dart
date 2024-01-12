import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:zoy/themes/app_colors.dart';

class CustomeDropdown extends StatelessWidget {
  final TextStyle textStyle;

  final String name;
  final String initialValue;
  final List<Map<String, String>> itemList;

  const CustomeDropdown(
      {super.key,
      required this.textStyle,
      required this.name,
      required this.initialValue,
      required this.itemList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: FormBuilderDropdown(
          initialValue: initialValue,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            fillColor: AppColors.bgColor, // Change this to your desired color
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
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
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          name: name,
          items: [
            ...itemList.map((e) => DropdownMenuItem(
                value: e['value'],
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(e['label']!),
                  ],
                )))
          ],
          onChanged: (value) {}),
    );
  }
}
