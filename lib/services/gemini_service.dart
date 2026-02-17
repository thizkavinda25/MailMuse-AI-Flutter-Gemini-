import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GeminiService {
  static const String _apiKey = "AIzaSyCktHsSm1nAkxTQhdqubhT-o-jC9ehlFoo";

  static const String _baseUrl =
      "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent";

  final Logger _logger = Logger();

  Future<String> generateEmail({
    required String topic,
    required String tone,
  }) async {
    final url = Uri.parse("$_baseUrl?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Write a $tone email about the following topic:\n\n$topic",
                },
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        _logger.e(
          "Gemini API Error: ${response.statusCode} - ${response.body}",
        );
        throw Exception("Failed to generate email");
      }
    } catch (e) {
      _logger.e("Exception: $e");
      rethrow;
    }
  }
}
