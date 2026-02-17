import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class EmailProvider extends ChangeNotifier {
  String _selectedTone = 'Formal & Professional';
  String _generatedEmail = '';
  bool _isLoading = false;

  final GeminiService _geminiService = GeminiService();

  String get selectedTone => _selectedTone;
  String get generatedEmail => _generatedEmail;
  bool get isLoading => _isLoading;

  void updateTone(String tone) {
    _selectedTone = tone;
    notifyListeners();
  }

  Future<void> generateEmail(
    String topic,
    TextEditingController controller,
  ) async {
    if (topic.trim().isEmpty) return;

    _isLoading = true;
    _generatedEmail = '';
    notifyListeners();

    try {
      final result = await _geminiService.generateEmail(
        topic: topic,
        tone: _selectedTone,
      );

      _generatedEmail = result;
      controller.clear();
    } catch (e) {
      _generatedEmail = "Error generating email. Please try again.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
