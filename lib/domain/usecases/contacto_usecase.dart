import 'package:qr_code_gestor/domain/models/contacto.dart';

import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactUseCase {
  final ContactoRepository contactoRepository;

  ContactUseCase({required this.contactoRepository});

  Future<void> callAdd(ContactoModel contact) async {
    await contactoRepository.addContact(contact);
  }

  Future<ContactoModel?> callScan(String contact) async {
    return await contactoRepository.scanQr(contact);
  }

  Stream<List<ContactoModel>> getContacts() async* {
    yield* contactoRepository.getContacts();
  }
}
