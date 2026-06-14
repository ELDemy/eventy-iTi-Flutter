import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppIcons.appLogo, height: 80),
        const SizedBox(height: 8),
        Text(AppStrings.appName, style: AppTextStyles.brandLogo),
      ],
    );
  }
}
