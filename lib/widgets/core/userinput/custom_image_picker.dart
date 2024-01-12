import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(0, 0, 115, 115);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}

class CustomImagePicker extends StatelessWidget {
  final String name;
  const CustomImagePicker({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: 120,
      height: 120,
      child: Material(
        child: FormBuilderImagePicker(
          name: name,
          backgroundColor: Colors.white,
          iconColor: Colors.transparent,
          maxImages: 1,
          showDecoration: false,
          previewAutoSizeWidth: true,
          bottomSheetPadding: const EdgeInsets.all(10),
          transformImageWidget: (context, displayImage) => ClipOval(
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Material(child: displayImage),
            ),
          ),
          placeholderImage: const NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSay_7Jv-aXnExUdMP8aAG66UIiGzbjm_3p3w&usqp=CAU'),
        ),
      ),
    );
  }
}
