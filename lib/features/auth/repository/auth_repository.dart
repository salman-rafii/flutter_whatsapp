import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/common/repositories/common_firebase_storage_repository.dart';
import 'package:flutter_whatsapp/common/utils/utils.dart';
import 'package:flutter_whatsapp/features/auth/screens/otp_screen.dart';
import 'package:flutter_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:flutter_whatsapp/models/user_model.dart';
import 'package:flutter_whatsapp/screens/mobile_layout_screen.dart';

final authrepositoryProvider = Provider(
    (ref) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository(this.auth, this.firestore);

// function to check current user

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

// function to sign in with phone & get the OTP
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((verificationId, resendToken) async {
          Navigator.pushNamed(context, OTPScreen.routeName,
              arguments: verificationId);
        }),
        codeAutoRetrievalTimeout: ((verificationId) {}),
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context: context,
        content: e.message!,
      );
    }
  }

// function to verify the OTP
  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        context: context,
        content: e.message!,
      );
    }
  }

  // function to save user data to firebase

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
    // bool mounted = true
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase("profilePic/$uid", profilePic);
      }

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []);
      await firestore.collection("users").doc(uid).set(user.toMap());
      // if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLayoutScreen()),
          (route) => false);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
