import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          FirebaseAuth.instance.currentUser != null
              ? 'This page is under development, stay tuned for updates!'
              : 'Please log in to view your history',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.black),
        ),
      ),
    );
  }
}
