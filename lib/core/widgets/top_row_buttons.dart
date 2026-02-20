import 'package:flutter/material.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class TopRowButtons extends StatefulWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onSignin;
  const TopRowButtons({super.key, this.onLogin, this.onSignin});

  @override
  State<TopRowButtons> createState() => _TopRowButtonsState();
}

class _TopRowButtonsState extends State<TopRowButtons> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallDevice = screenWidth < 360;
    final padding = isSmallDevice ? 12.0 : 16.0;
    final fontSize = isSmallDevice ? 14.0 : 16.0;
    final verticalPadding = isSmallDevice ? 12.0 : 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onLogin,

              label: Text(
                'Login',
                style: TextStyle(
                  color: const Color.fromARGB(255, 33, 114, 243),
                  fontSize: fontSize,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                side: const BorderSide(
                  color: Color.fromARGB(90, 65, 33, 243),
                  width: 1.7,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(width: padding),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton.icon(
                onPressed: widget.onSignin,

                label: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
