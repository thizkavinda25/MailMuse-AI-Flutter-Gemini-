import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mail_muse/screens/home_screen.dart';
import 'providers/email_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmailProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MailMuse AI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
