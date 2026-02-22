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
import 'package:mail_muse/screens/auth/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/auth_header_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, widget) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: authProvider.isLoading,
                child: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;
                      final screenHeight = constraints.maxHeight;
                      final isSmallScreen = screenWidth < 360;

                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 18 : 25,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: screenHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: screenHeight * 0.05),

                              AuthHeaderText(
                                greetText: 'Welcome Back',
                                subText:
                                    'Login to continue generating instant email',
                              ),

                              SizedBox(height: screenHeight * 0.04),

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
                                showForgotPassword: true,
                                controller: authProvider.passwordController,
                              ),

                              CustomButton(
                                text: 'Login',
                                onTap: () {
                                  authProvider.signIn(context);
                                },
                              ),

                              SizedBox(height: screenHeight * 0.02),

                              DividerRow(),

                              SizedBox(height: screenHeight * 0.025),

                              AuthMethodButtons(
                                onGoogle: () {
                                  authProvider.signinWithGoogle(context);
                                },
                                onApple: () {},
                              ),

                              SizedBox(height: screenHeight * 0.02),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.hintTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CustomRoutes.push(
                                        context,
                                        const SignupScreen(),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.bottomNavSelectColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmallScreen ? 12 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: screenHeight * 0.05),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
