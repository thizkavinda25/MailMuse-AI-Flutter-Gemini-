import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomTextfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.isPassword = false,
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
      padding: EdgeInsets.only(bottom: screenWidth * 0.06),
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
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFieldBackground,
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.035,
              ),
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
              prefixIcon: Icon(
                widget.prefixIcon,
                color: AppColors.prefixIconColor,
                size: isSmallScreen ? 20 : 24,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      icon: Icon(
                        color: AppColors.prefixIconColor,
                        isObscureText ? Icons.visibility : Icons.visibility_off,
                        size: isSmallScreen ? 20 : 24,
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: poppins.copyWith(color: AppColors.hintTextColor),
            ),
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            cursorColor: AppColors.hintTextColor,
            obscureText: widget.isPassword && isObscureText,
            controller: widget.controller,
          ),
          if (widget.isPassword == true)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: poppins.copyWith(
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
