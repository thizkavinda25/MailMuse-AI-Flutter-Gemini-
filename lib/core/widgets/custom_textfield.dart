import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/screens/auth/reset_password_screen.dart';

class CustomTextfield extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final bool showForgotPassword;
  final String? Function(String?)? validator; // ✅ Added validator

  const CustomTextfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.showForgotPassword = false,
    this.validator,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final poppins = GoogleFonts.poppins();
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: poppins.copyWith(
              color: AppColors.generatedEmailFont,
              fontWeight: FontWeight.w600,
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
          SizedBox(height: screenWidth * 0.025),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && isObscureText,
            validator: widget.validator,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            cursorColor: AppColors.hintTextColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFieldBackground,
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.035,
              ),

              // ── Normal border ──────────────────────────────
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColors.textFieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColors.textFieldBorder,
                ),
              ),

              // ── Error borders in red ───────────────────────
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  width: 1.2,
                  color: Colors.redAccent,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  width: 1.5,
                  color: Colors.redAccent,
                ),
              ),

              // ── Error text style ───────────────────────────
              errorStyle: poppins.copyWith(
                color: Colors.redAccent,
                fontSize: isSmallScreen ? 11 : 12,
                fontWeight: FontWeight.w500,
              ),

              prefixIcon: Icon(
                widget.prefixIcon,
                color: AppColors.prefixIconColor,
                size: isSmallScreen ? 20 : 24,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() => isObscureText = !isObscureText);
                      },
                      icon: Icon(
                        isObscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.prefixIconColor,
                        size: isSmallScreen ? 20 : 24,
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: poppins.copyWith(color: AppColors.hintTextColor),
            ),
          ),
          if (widget.showForgotPassword)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    CustomRoutes.push(context, ResetPasswordScreen()),
                child: Text(
                  'Forgot Password?',
                  style: poppins.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.bottomNavSelectColor,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
