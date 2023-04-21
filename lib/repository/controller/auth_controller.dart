import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hola/repository/auth.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(authRepo: authRepository, ref: ref);
  },
);

class AuthController {
  final AuthRepo authRepo;
  final ProviderRef ref;

  AuthController({required this.authRepo, required this.ref});

  void saveUserInfoToFirestore({
    required String username,
    required var profileImageUrl,
    required BuildContext context,
    required bool mounted,
  }) {
    authRepo.saveUserInfoToFirestore(
      username: username,
      ref: ref,
      profileImageUrl: profileImageUrl,
      context: context,
      mounted: mounted,
    );
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) {
    authRepo.sendSmsCode(context: context, phoneNumber: phoneNumber);
  }

  void verifySmsCode(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) {
    authRepo.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }
}
