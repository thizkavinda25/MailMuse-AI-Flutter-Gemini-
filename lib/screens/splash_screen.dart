import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mail_muse/constants/app_colors.dart';
import 'package:mail_muse/screens/main_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final poppins = GoogleFonts.poppins();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainBody()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/round.json',
                      filterQuality: FilterQuality.high,
                      width: screenWidth * 0.4,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text.rich(
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                      ),
                      TextSpan(
                        text: 'MailMuse',
                        children: [
                          TextSpan(
                            text: ' AI',
                            style: poppins.copyWith(
                              color: AppColors.subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'AI EMAIL GENERATOR',
                      style: poppins.copyWith(
                        color: AppColors.hintTextColor,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Lottie.asset(
                      'assets/lottie/loader.dart.json',
                      filterQuality: FilterQuality.high,
                      repeat: false,
                      width: screenWidth * 0.5,
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Text(
                      'Initializing intelligent workspace...',
                      style: poppins.copyWith(
                        color: AppColors.hintTextColor,
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version 1.0.0',
                  style: const TextStyle(color: AppColors.hintTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
