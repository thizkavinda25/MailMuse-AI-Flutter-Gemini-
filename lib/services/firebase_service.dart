import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:logger/logger.dart';
import 'package:mail_muse/core/utils/custom_dialogs.dart';
import 'package:mail_muse/core/utils/custom_routes.dart';
import 'package:mail_muse/models/email_model.dart';
import 'package:mail_muse/screens/auth/login_screen.dart';

class FirebaseService {
  Future<User?> createUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'The account already exists for that email',
        );
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<User?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        CustomDialogs.showEmptyFieldDialog(
          context,
          'Please check your email and password',
        );
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    CustomRoutes.pushAndRemoveUntil(context, LoginScreen());
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> saveEmailToHistory({
    required String uid,
    required EmailModel email,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('emailHistory')
        .add(email.toMap());
  }

  Future<List<EmailModel>> fetchEmailHistory(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('emailHistory')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => EmailModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> deleteEmailFromHistory({
    required String uid,
    required String emailId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('emailHistory')
        .doc(emailId)
        .delete();
  }
}
