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

  // ✅ Form keys — one per screen
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

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

  // ── Validators ────────────────────────────────────────────────────────────

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value.trim() != _passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ── Auth methods — Firebase logic unchanged ───────────────────────────────

  Future<void> signUp(BuildContext context) async {
    // ✅ Validate form first — shows inline red errors
    if (!signUpFormKey.currentState!.validate()) return;

    try {
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
        CustomRoutes.pushAndRemoveUntil(context, MainBody());
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
    if (!signInFormKey.currentState!.validate()) return;

    try {
      _startLoading("Signing in");

      final user = await FirebaseService().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );

      if (user != null) {
        controllerClear();
        CustomRoutes.pushAndRemoveUntil(context, MainBody());
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
      _startLoading("Signing in with Google...");

      final userCredential = await FirebaseService().signInWithGoogle();
      if (userCredential == null) return;
      if (!context.mounted) return;
      CustomRoutes.pushAndRemoveUntil(context, MainBody());
    } catch (e) {
      if (!context.mounted) return;
      CustomDialogs.showEmptyFieldDialog(
        context,
        'Google Sign-In failed. Please try again.',
      );
    } finally {
      _stopLoading();
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (!resetFormKey.currentState!.validate()) return;

    try {
      _startLoading("Sending reset email...");

      await FirebaseService().resetPassword(
        email: _emailController.text.trim(),
      );

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
