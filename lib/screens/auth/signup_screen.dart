import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/core/widgets/auth_method_buttons.dart';
import 'package:mail_muse/core/widgets/custom_button.dart';
import 'package:mail_muse/core/widgets/custom_textfield.dart';
import 'package:mail_muse/core/widgets/divider_row.dart';
import 'package:mail_muse/core/widgets/loading_overlay.dart';
import 'package:mail_muse/providers/auth_provider.dart';
import 'package:mail_muse/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/auth_header_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, widget) {
        return Stack(
          children: [
            IgnorePointer(
              ignoring: authProvider.isLoading,
              child: Scaffold(
                backgroundColor: AppColors.primary,
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: AuthHeaderText(
                          greetText: 'Create Account',
                          subText: 'Join us to start generating professional email',
                        ),
                      ),
              
                      SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              CustomTextfield(
                                labelText: 'Name',
                                prefixIcon: Icons.person_2,
                                hintText: 'Your Name',
                                controller: authProvider.nameController,
                              ),
              
                              CustomTextfield(
                                labelText: 'Email Address',
                                prefixIcon: Icons.mail,
                                hintText: 'name@company.com',
                                controller: authProvider.emailController,
                              ),
              
                              CustomTextfield(
                                labelText: 'Password',
                                prefixIcon: CupertinoIcons.padlock_solid,
                                hintText: '',
                                isPassword: true,
                                controller: authProvider.passwordController,
                              ),
              
                              CustomTextfield(
                                labelText: 'Confirm Password',
                                prefixIcon: CupertinoIcons.padlock_solid,
                                hintText: '',
                                isPassword: true,
                                controller: authProvider.confirmPasswordController,
                              ),
              
                              CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  authProvider.signUp(context);
                                },
                              ),
              
                              SizedBox(height: 20),
              
                              DividerRow(),
              
                              SizedBox(height: 20),
              
                              AuthMethodButtons(onGoogle: () {
                                authProvider.signinWithGoogle(context);
                              }, onApple: () {}),
              
                              SizedBox(height: 20),
              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.hintTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CustomRoutes.push(context, LoginScreen());
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.bottomNavSelectColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
