import 'package:flutter/material.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/widgets/auth_header_text.dart';
import 'package:mail_muse/core/widgets/custom_button.dart';
import 'package:mail_muse/core/widgets/custom_textfield.dart';
import 'package:mail_muse/core/widgets/divider_row.dart';
import 'package:mail_muse/core/widgets/loading_overlay.dart';
import 'package:mail_muse/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, widget) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: authProvider.isLoading,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthHeaderText(
                          greetText: 'Reset Password',
                          subText: 'Enter email for send password reset link',
                        ),
                        SizedBox(height: height * 0.06),
                        CustomTextfield(
                          labelText: 'Email',
                          hintText: 'name@company.com',
                          prefixIcon: Icons.email,
                          controller: authProvider.emailController,
                        ),
                        SizedBox(height: height * 0.04),
                        CustomButton(
                          text: 'Send',
                          onTap: () {
                            authProvider.resetPassword(context);
                          },
                        ),
                        SizedBox(height: height * 0.04),
                        DividerRow(),
                        SizedBox(height: height * 0.04),
                        CustomButton(
                          text: 'Remember Me',
                          onTap: () {
                            Navigator.pop(context);
                          },
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
      ),
    );
  }
}
