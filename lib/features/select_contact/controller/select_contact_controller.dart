import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_whatsapp/features/select_contact/repository/select_contact_repository.dart';

final getContactsController = FutureProvider((ref) {
  final selectContactRepo = ref.watch(selectContactProvider);
  return selectContactRepo.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  var selectContactRepository = ref.watch(selectContactProvider);
  return SelectContactController(
      ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContactController {
  ProviderRef ref;
  SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
