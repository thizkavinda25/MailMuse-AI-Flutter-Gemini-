import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color.fromRGBO(255, 255, 255, 1);
  static const Color hintTextColor = Color.fromRGBO(158, 158, 158, 1);
  static const Color background = Color(0xFFF5F5F5);
  static const Color rowIconColor = Color.fromRGBO(97, 97, 97, 1);
  static const Color generatedEmailFont = Color.fromRGBO(66, 66, 66, 1);
  static const Color subTextColor = Color.fromARGB(255, 100, 143, 235);
  static const Color circleAvatarBackground = Color.fromRGBO(227, 242, 253, 1);
  static const Color bottomNavSelectColor = Color.fromARGB(255, 72, 77, 225);
  static const Color black = Colors.black;
  static const Color textFieldBackground = Color.fromARGB(16, 160, 221, 241);
  static const Color prefixIconColor =Color.fromARGB(255, 160, 174, 178);
  static const Color textFieldBorder = Color.fromARGB(247, 224, 224, 224);
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF5E5CE6), Color(0xFF8E7BFF)],
  );
}
