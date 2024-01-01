import 'package:flutter/material.dart';
import 'package:zoe/themes/app_text_styles.dart';
import 'package:zoe/widgets/core/buttons/secondary_button.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: const LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlue
            ], // Customize your gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Premium',
                  style: AppTextStyle.boldBlack18,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Unlock all of our features to be in complete control of you experience',
                  style: AppTextStyle.mediumBlack14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                SecondaryButton(
                    btnText: 'Upgrade from 49.00 INR', onClickHandler: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
