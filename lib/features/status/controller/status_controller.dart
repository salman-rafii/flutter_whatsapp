// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/features/auth/controller/auth_controller.dart';

import 'package:flutter_whatsapp/features/status/repository/status_repository.dart';

final statusControllerProvider = Provider(
  (ref) => StatustController(
    statusRepository: ref.read(statusRepositoryProvider),
    ref: ref,
  ),
);

class StatustController {
  final StatusRepository statusRepository;
  final ProviderRef ref;
  StatustController({
    required this.statusRepository,
    required this.ref,
  });

  void addStatus(File file, BuildContext context) {
    ref.watch(userDataAuthProvider).whenData((value) {
      statusRepository.uploadStatus(
          username: value!.name,
          profilePic: value.profilePic,
          phoneNumber: value.phoneNumber,
          statusImage: file,
          context: context);
    });
  }
}
