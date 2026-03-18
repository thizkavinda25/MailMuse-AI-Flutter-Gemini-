import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mail_muse/models/email_model.dart';
import 'package:mail_muse/services/firebase_service.dart';
import 'package:mail_muse/services/groq_service.dart';
import 'package:mail_muse/core/utils/custom_dialogs.dart';
import 'package:share_plus/share_plus.dart';

class EmailProvider extends ChangeNotifier {
  String _selectedTone = 'Formal & Professional';
  String _generatedEmail = '';
  bool _isLoading = false;

  final GroqService _groqService = GroqService();

  String get selectedTone => _selectedTone;
  String get generatedEmail => _generatedEmail;
  bool get isLoading => _isLoading;

  void updateTone(String tone) {
    _selectedTone = tone;
    notifyListeners();
  }

  Future<void> generateEmail(String topic, BuildContext context) async {
    if (topic.trim().isEmpty) {
      CustomDialogs.showEmptyFieldDialog(context, 'Please enter a topic');
      return;
    }

    _isLoading = true;
    _generatedEmail = '';
    notifyListeners();

    try {
      _generatedEmail = await _groqService.generateEmail(
        topic: topic,
        tone: _selectedTone,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null && _generatedEmail.isNotEmpty) {
        await FirebaseService().saveEmailToHistory(
          uid: user.uid,
          email: EmailModel(
            tone: _selectedTone,
            topic: topic,
            generatedEmail: _generatedEmail,
          ),
        );
      }
    } catch (e) {
      _generatedEmail = "Something went wrong.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeGeneratedEmail() async {
    _generatedEmail = '';
    notifyListeners();
  }

  Future<void> shareGeneratedEmail(BuildContext context) async {
    if (_generatedEmail.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No email to share")));
      return;
    }

    await Share.share(_generatedEmail, subject: "Generated Email");
  }
}
