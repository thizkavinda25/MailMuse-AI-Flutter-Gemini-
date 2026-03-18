import 'package:cloud_firestore/cloud_firestore.dart';

class EmailModel {
  final String? id;
  final String tone;
  final String topic;
  final String generatedEmail;
  final DateTime? createdAt;

  EmailModel({
    this.id,
    required this.tone,
    required this.topic,
    required this.generatedEmail,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "tone": tone,
      "topic": topic,
      "generatedEmail": generatedEmail,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }

  factory EmailModel.fromMap(String id, Map<String, dynamic> map) {
    return EmailModel(
      id: id,
      tone: map['tone'] ?? '',
      topic: map['topic'] ?? '',
      generatedEmail: map['generatedEmail'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}