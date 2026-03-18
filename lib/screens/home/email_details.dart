import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/models/email_model.dart';
import 'package:mail_muse/providers/email_provider.dart';
import 'package:mail_muse/providers/history_provider.dart';
import 'package:provider/provider.dart';

class EmailDetailScreen extends StatelessWidget {
  final EmailModel email;

  const EmailDetailScreen({super.key, required this.email});

  Color _toneBgColor(String tone) {
    switch (tone) {
      case 'Casual & Friendly':
        return const Color.fromARGB(35, 118, 233, 125);
      case 'Formal & Professional':
        return const Color.fromARGB(24, 89, 69, 205);
      case 'Concise':
        return const Color.fromARGB(27, 141, 6, 168);
      case 'Enthusiastic':
        return const Color.fromARGB(27, 168, 149, 6);
      default:
        return const Color.fromARGB(34, 233, 133, 118);
    }
  }

  Color _toneTextColor(String tone) {
    switch (tone) {
      case 'Casual & Friendly':
        return Colors.green;
      case 'Formal & Professional':
        return const Color.fromARGB(255, 72, 6, 226);
      case 'Concise':
        return const Color.fromARGB(255, 205, 7, 255);
      case 'Enthusiastic':
        return const Color.fromARGB(255, 168, 149, 6);
      default:
        return const Color.fromARGB(255, 233, 133, 118);
    }
  }

  String _toneLabel(String tone) {
    switch (tone) {
      case 'Formal & Professional':
        return 'Formal Tone';
      case 'Casual & Friendly':
        return 'Casual Tone';
      default:
        return tone;
    }
  }

  int _wordCount(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hPadding = screenWidth < 360 ? 14.0 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: Text(
          'Email Details',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Email'),
                    content: const Text(
                      'Are you sure you want to delete this email from history?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  await context.read<HistoryProvider>().deleteEmail(email.id!);
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(20, 233, 62, 62),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOPIC',
                            style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500],
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            email.topic,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(20, 89, 69, 205),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.mail_outline_rounded,
                        size: 20,
                        color: Color.fromARGB(255, 89, 69, 205),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _toneBgColor(email.tone),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 14,
                          color: _toneTextColor(email.tone),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _toneLabel(email.tone),
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _toneTextColor(email.tone),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (email.createdAt != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(15, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('MMM d, yyyy').format(email.createdAt!),
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Generated Email',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                    ),
                  ),
                  Text(
                    '${_wordCount(email.generatedEmail)} Words',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SelectableText(
                  email.generatedEmail,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    height: 1.65,
                    color: Colors.grey[800],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: email.generatedEmail));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email copied to clipboard')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        size: 18,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {
                  Provider.of<EmailProvider>(
                    context,
                    listen: false,
                  ).shareGeneratedEmail(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.share_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Share Email',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
