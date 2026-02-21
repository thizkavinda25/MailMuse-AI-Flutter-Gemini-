import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/widgets/auth_method_buttons.dart';
import 'package:mail_muse/core/widgets/custom_button.dart';
import 'package:mail_muse/core/widgets/custom_textfield.dart';
import 'package:mail_muse/core/widgets/divider_row.dart';

import '../../core/widgets/auth_header_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final poppins = GoogleFonts.poppins();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthHeaderText(
                  greetText: 'Create Account',
                  subText: 'Join us to start generating professional emails',
                ),
                SizedBox(height: 50),
                CustomTextfield(
                  labelText: 'Email Address',
                  prefixIcon: Icons.mail,
                  hintText: 'name@company.com',
                ),
                CustomTextfield(
                  labelText: 'Password',
                  prefixIcon: CupertinoIcons.padlock_solid,
                  hintText: '',
                  isPassword: true,
                ),
                CustomButton(text: 'Login', onTap: () {}),
                SizedBox(height: 20),
                DividerRow(),
                SizedBox(height: 25),
                AuthMethodButtons(onGoogle: () {}, onApple: () {}),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: poppins.copyWith(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: poppins.copyWith(
                          color: AppColors.bottomNavSelectColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
