import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/email_provider.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final List<String> tones = [
      'Formal & Professional',
      'Casual & Friendly',
      'Concise',
      'Enthusiastic',
      'Persuasive',
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.grey.shade100,
          textStyle: TextStyle(color: Colors.black),
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: provider.updateTone,
        itemBuilder: (context) =>
            tones.map((t) => PopupMenuItem(value: t, child: Text(t))).toList(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 10 : 14,
            vertical: isSmallScreen ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: isSmallScreen ? 14 : 16,
                backgroundColor: AppColors.circleAvatarBackground,
                child: Icon(
                  Icons.mail_sharp,
                  size: isSmallScreen ? 16 : 18,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(width: isSmallScreen ? 8 : 12),
              Flexible(
                child: Text(
                  provider.selectedTone,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 6 : 10),
              Icon(
                Icons.keyboard_arrow_down,
                size: isSmallScreen ? 18 : 20,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
