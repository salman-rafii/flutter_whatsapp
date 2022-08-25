import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/features/auth/repository/auth_repository.dart';
import 'package:flutter_whatsapp/models/user_model.dart';

final authcontrollerProvider = Provider((ref) {
  final authRepository = ref.watch(authrepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataProvider = FutureProvider((ref) {
  final authControllerProvider = ref.watch(authcontrollerProvider);
  return authControllerProvider.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

// Function to get the user data
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

// controller of phone auth
  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

// controller of verifying otp
  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOtp(
        context: context, verificationId: verificationId, userOtp: userOTP);
  }

// controller for saving user data to firebase
  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
        name: name, profilePic: profilePic, ref: ref, context: context);
  }
}
