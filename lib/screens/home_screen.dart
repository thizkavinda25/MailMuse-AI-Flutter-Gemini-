import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(),
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
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'e.g. Leave request for 3 days due to illness',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.grey.shade500,
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
                    onTap: () => provider.generateEmail(
                      topicController.text,
                      topicController,
                    ),
                  ),
                  SizedBox(height: 30),
                  _subText('Generated Email'),
                  SizedBox(height: 15),
        
                  if (provider.isLoading)
                    Center(child: CircularProgressIndicator()),
        
                  if (provider.generatedEmail.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                    ClipboardData(text: provider.generatedEmail),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Email copied successfully"),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      size: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Copy",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700,
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
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
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
