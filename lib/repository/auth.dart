// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hola/common/helper/show_alert.dart';
import 'package:hola/common/models/user_model.dart';
import 'package:hola/common/repository/firebase_storage.dart';
import 'package:hola/routes/routes.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepo(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepo({
    required this.auth,
    required this.firestore,
  });

  void saveUserInfoToFirestore({
    required String username,
    required var profileImageUrl,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      print(uid);
      String profileImageUrl = '';

      profileImageUrl = await ref
          .read(firebaseStorageRepository)
          .storeFileToFirebase('profileImage/$uid', profileImageUrl);

      UserModel user = UserModel(
          username: username,
          uid: uid,
          profileImageUrl: profileImageUrl,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []);
      await firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifySmsCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required mounted}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.userInfo, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (smsCodeId, resendSmsCode) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verification, (route) => false,
              arguments: {
                'phoneNumber': phoneNumber,
                'smsCodeId': smsCodeId,
              });
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
