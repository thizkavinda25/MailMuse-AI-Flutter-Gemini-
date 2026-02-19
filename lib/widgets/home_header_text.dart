import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeaderText extends StatelessWidget {
  const HomeHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 360 ? 24.0 : 30.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Generate Professional",
          style: GoogleFonts.roboto(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade900,
          ),
        ),
        Text(
          "Emails Instantly",
          style: GoogleFonts.roboto(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 33, 114, 243),
          ),
        ),
      ],
    );
  }
}
