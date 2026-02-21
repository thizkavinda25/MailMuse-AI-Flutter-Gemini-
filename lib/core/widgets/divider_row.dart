import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    final poppins = GoogleFonts.poppins();
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.hintTextColor, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6.0 : 8.0),
          child: Text(
            'Or continue with',
            style: poppins.copyWith(
              color: AppColors.hintTextColor,
              fontWeight: FontWeight.w600,
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.hintTextColor, thickness: 1)),
      ],
    );
  }
}
