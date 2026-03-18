import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mail_muse/models/email_model.dart';
import 'package:mail_muse/services/firebase_service.dart';
import 'package:share_plus/share_plus.dart';

class HistoryProvider extends ChangeNotifier {
  List<EmailModel> _emails = [];
  bool _isLoading = false;

  List<EmailModel> get emails => _emails;
  bool get isLoading => _isLoading;

  Future<void> loadHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _emails = await FirebaseService().fetchEmailHistory(user.uid);
    } catch (e) {
      _emails = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEmail(String emailId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseService().deleteEmailFromHistory(
      uid: user.uid,
      emailId: emailId,
    );

    _emails.removeWhere((e) => e.id == emailId);
    notifyListeners();
  }

  Future<void> shareEmail(EmailModel email) async {
  await Share.share(
    email.generatedEmail,
    subject: email.topic,
  );
}



}
