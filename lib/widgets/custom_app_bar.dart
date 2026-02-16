import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135,
      color: Colors.white,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lottie/gemini.json', repeat: true, height: 65),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MailMuse AI',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'AI EMAIL GENERATOR',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 100, 143, 235),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
