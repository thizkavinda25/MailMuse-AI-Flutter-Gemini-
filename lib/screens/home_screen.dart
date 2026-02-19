import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mail_muse/constants/app_colors.dart';
import 'package:mail_muse/widgets/bottom_row_buttons.dart';
import 'package:provider/provider.dart';
import 'package:mail_muse/widgets/custom_app_bar.dart';
import 'package:mail_muse/widgets/custom_button.dart';
import 'package:mail_muse/widgets/home_header_text.dart';
import 'package:mail_muse/widgets/popup_menu.dart';
import '../providers/email_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeaderText(),
                  SizedBox(height: 25),
                  _subText('Select Email Tone'),
                  SizedBox(height: 15),
                  const PopupMenu(),
                  SizedBox(height: 20),
                  _subText('Enter Email Topic'),
                  SizedBox(height: 15),
                  TextField(
                    controller: topicController,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.primary,
                      hintText: 'e.g. Leave request for 3 days due to illness',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.hintTextColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    text: 'Generate Email',
                    onTap: () async {
                      await provider.generateEmail(
                        topicController.text,
                        context,
                      );
                      if (provider.generatedEmail.isNotEmpty &&
                          !provider.generatedEmail.contains("Error")) {
                        topicController.clear();
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  if (provider.generatedEmail.isNotEmpty)
                    _subText('Generated Email'),
                  SizedBox(height: 15),

                  if (provider.isLoading)
                    Center(
                      child: Lottie.asset(
                        'assets/lottie/loading.json',
                        repeat: true,
                        height: 150,
                      ),
                    ),

                  if (provider.generatedEmail.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: provider.generatedEmail,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Email copied successfully",
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      size: 18,
                                      color: AppColors.rowIconColor,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Copy",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.rowIconColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SelectableText(
                            provider.generatedEmail,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: AppColors.generatedEmailFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 20),
                  if (provider.generatedEmail.isNotEmpty)
                    BottomRowButtons(
                      onClear: () {
                        provider.removeGeneratedEmail();
                      },
                      onShare: () {
                        provider.shareGeneratedEmail(context);
                      },
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _subText(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade800,
    ),
  );
}
