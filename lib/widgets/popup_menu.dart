import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/email_provider.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailProvider>(context);

    final List<String> tones = [
      'Formal & Professional',
      'Casual & Friendly',
      'Concise',
      'Enthusiastic',
      'Persuasive',
    ];

    return PopupMenuButton<String>(
      onSelected: provider.updateTone,
      itemBuilder: (context) =>
          tones.map((t) => PopupMenuItem(value: t, child: Text(t))).toList(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.mail_sharp,
                  size: 18, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 12),
            Text(
              provider.selectedTone,
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
