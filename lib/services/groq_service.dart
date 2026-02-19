import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GroqService {
  static final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  static const String _baseUrl =
      "https://api.groq.com/openai/v1/chat/completions";

  Future<String> generateEmail({
    required String topic,
    required String tone,
  }) async {
    final prompt = "Write a $tone email about the following topic: $topic";

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a professional email writing assistant. Output only the email body.",
            },
            {"role": "user", "content": prompt},
          ],
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        Logger().e("Groq Error: ${response.body}");
        return "Error: Failed to connect to AI service (Status: ${response.statusCode})";
      }
    } catch (e) {
      Logger().e("Connection Error: $e");
      return "Something went wrong. Please check your internet connection.";
    }
  }
}
