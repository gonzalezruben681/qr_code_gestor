import 'package:qr_code_gestor/domain/models/contacto.dart';

import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactUseCase {
  final ContactoRepository contactoRepository;

  ContactUseCase({required this.contactoRepository});

  Future<void> addContact(ContactoModel contact) async {
    return await contactoRepository.addContact(contact);
  }

  Future<ContactoModel?> callScan(String contact) async {
    return await contactoRepository.scanQr(contact);
  }

  Stream<List<ContactoModel>> getContacts() async* {
    yield* contactoRepository.getContacts();
  }

  Future<bool> deleteContact(ContactoModel contact) async {
    return await contactoRepository.deleteContact(contact);
  }
}
