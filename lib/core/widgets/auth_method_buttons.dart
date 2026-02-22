import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class AuthMethodButtons extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onApple;

  const AuthMethodButtons({
    super.key,
    required this.onGoogle,
    required this.onApple,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 360;

        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onGoogle,
                child: _socialButton(
                  icon: Brand(Brands.google, size: isSmallScreen ? 18 : 22),
                  text: 'Google',
                  isSmall: isSmallScreen,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: onApple,
                child: _socialButton(
                  icon: Icon(BoxIcons.bxl_apple, size: isSmallScreen ? 18 : 22),
                  text: 'Apple',
                  isSmall: isSmallScreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _socialButton({
    required Widget icon,
    required String text,
    required bool isSmall,
  }) {
    return Container(
      height: isSmall ? 45 : 50,
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border.all(color: AppColors.textFieldBorder),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: isSmall ? 12 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
