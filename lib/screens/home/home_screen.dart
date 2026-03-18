import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/core/widgets/bottom_row_buttons.dart';
import 'package:mail_muse/core/widgets/top_row_buttons.dart';
import 'package:mail_muse/screens/auth/login_screen.dart';
import 'package:mail_muse/screens/auth/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:mail_muse/core/widgets/custom_app_bar.dart';
import 'package:mail_muse/core/widgets/custom_button.dart';
import 'package:mail_muse/core/widgets/home_header_text.dart';
import 'package:mail_muse/core/widgets/popup_menu.dart';
import '../../providers/email_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController topicController = TextEditingController();

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final hPadding = screenWidth < 360 ? 12.0 : 15.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            if (FirebaseAuth.instance.currentUser == null) ...[
              TopRowButtons(
                onLogin: () => CustomRoutes.push(context, LoginScreen()),
                onSignin: () => CustomRoutes.push(context, SignupScreen()),
              ),
              const SizedBox(height: 20),
            ],

            const HomeHeaderText(),
            const SizedBox(height: 25),

            _subText('Select Email Tone'),
            const SizedBox(height: 15),
            const PopupMenu(),
            const SizedBox(height: 20),

            _subText('Enter Email Topic'),
            const SizedBox(height: 15),

            TextField(
              controller: topicController,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.primary,
                hintText: 'e.g. Leave request for 3 days due to illness',
                hintStyle: GoogleFonts.roboto(
                  fontSize: screenWidth < 360 ? 14 : 16,
                  color: AppColors.hintTextColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            CustomButton(
              text: 'Generate Email',
              onTap: () async {
                await provider.generateEmail(topicController.text, context);
                if (provider.generatedEmail.isNotEmpty &&
                    !provider.generatedEmail.contains("Error")) {
                  topicController.clear();
                }
              },
            ),
            const SizedBox(height: 20),

            if (provider.isLoading)
              Center(
                child: Lottie.asset(
                  'assets/lottie/loading.json',
                  filterQuality: FilterQuality.high,
                  repeat: true,
                  height: screenWidth < 360 ? 100 : 150,
                ),
              ),

            if (provider.generatedEmail.isNotEmpty) ...[
              _subText('Generated Email'),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: provider.generatedEmail),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Email copied successfully"),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.copy,
                              size: 18,
                              color: AppColors.rowIconColor,
                            ),
                            const SizedBox(width: 6),
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
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      provider.generatedEmail,
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth < 360 ? 14 : 16,
                        color: AppColors.generatedEmailFont,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BottomRowButtons(
                onClear: () => provider.removeGeneratedEmail(),
                onShare: () => provider.shareGeneratedEmail(context),
              ),
            ],

            const SizedBox(height: 30),
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
