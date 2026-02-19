import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mail_muse/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: isMobile ? 120 : 135,
      color: AppColors.primary,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Lottie.asset(
              'assets/lottie/gemini.json',
              repeat: true,
              height: isMobile ? 55 : 65,
            ),
            SizedBox(width: screenWidth * 0.05),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MailMuse AI',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'AI EMAIL GENERATOR',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 12 : 16,
                      color: AppColors.subTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
