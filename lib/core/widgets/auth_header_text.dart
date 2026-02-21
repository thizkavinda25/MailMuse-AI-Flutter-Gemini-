import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class AuthHeaderText extends StatelessWidget {
  final String greetText;
  final String subText;
  const AuthHeaderText({
    super.key,

    required this.greetText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    final poppins = GoogleFonts.poppins();
    return Column(
      children: [
        Lottie.asset('assets/lottie/round.json', width: 100),
        SizedBox(height: 8),
        Text(
          'MailMuse AI',
          style: poppins.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 35),
        Text(
          greetText,
          style: poppins.copyWith(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 8),
        Text(
          subText,
          style: poppins.copyWith(
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
