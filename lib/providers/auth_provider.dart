// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:mail_muse/core/utils/custom_dialogs.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/main_body.dart';
import 'package:mail_muse/services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String _loadingText = '';

  bool get isLoading => _isLoading;
  String get loadingText => _loadingText;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  void controllerClear() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _startLoading(String text) {
    _loadingText = text;
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (_nameController.text.trim().isEmpty ||
          _emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty ||
          _confirmPasswordController.text.trim().isEmpty) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please fill the all fields',
        );
        return;
      }

      if (!RegExp(
        r'^[^@]+@[^@]+\.[^@]+',
      ).hasMatch(_emailController.text.trim())) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please enter a valid email address',
        );
        return;
      }

      if (_passwordController.text.trim().length < 6) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Password must be at least 6 characters long',
        );
        return;
      }

      if (_confirmPasswordController.text.trim() !=
          _passwordController.text.trim()) {
        CustomDialogs.showEmptyFieldDialog(context, 'Passwords do not match');
        return;
      }

      _startLoading("Signing Up");

      final user = await FirebaseService().createUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "fullName": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        controllerClear();
        CustomRoutes.pushReplacement(context, MainBody());
      }
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
    } catch (e) {
      Logger().e("Signup Error: $e");
    } finally {
      _stopLoading();
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please fill in all the required fields.',
        );
        return;
      }

      if (!RegExp(
        r'^[^@]+@[^@]+\.[^@]+',
      ).hasMatch(_emailController.text.trim())) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please enter a valid email address.',
        );
        return;
      }

      _startLoading("Signing in");

      final user = await FirebaseService().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );

      if (user != null) {
        controllerClear();
        CustomRoutes.pushReplacement(context, MainBody());
      }
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
    } catch (e) {
      Logger().e("Login Error: $e");
    } finally {
      _stopLoading();
      controllerClear();
    }
  }

  Future<void> signinWithGoogle(BuildContext context) async {
    try {
      final userCredential = await FirebaseService().signInWithGoogle();

      if (userCredential == null) return;

      if (!context.mounted) return;

      CustomRoutes.pushReplacement(context, MainBody());
    } catch (e) {
      if (!context.mounted) return;

      CustomDialogs.showEmptyFieldDialog(
        context,
        'Google Sign-In failed. Please try again.',
      );
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      final email = _emailController.text.trim();

      if (email.isEmpty) {
        CustomDialogs.showEmptyFieldDialog(context, 'Email is required');
        return;
      }

      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

      if (!emailRegex.hasMatch(email)) {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please enter a valid email address',
        );
        return;
      }

      _startLoading("Sending reset email...");

      await FirebaseService().resetPassword(email: email);

      CustomRoutes.pop(context);
      CustomDialogs.showSucceededDialog(context, 'Password reset email sent');

      controllerClear();
    } on FirebaseAuthException catch (e) {
      CustomDialogs.showEmptyFieldDialog(
        context,
        e.message ?? 'An error occurred',
      );
    } catch (e) {
      CustomDialogs.showEmptyFieldDialog(
        context,
        'Failed to send reset email. Please try again.',
      );
    } finally {
      _stopLoading();
    }
  }
}
