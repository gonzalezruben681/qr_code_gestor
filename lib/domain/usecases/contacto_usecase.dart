import 'package:qr_code_gestor/domain/models/contacto.dart';

import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactUseCase {
  final ContactoRepository contactoRepository;

  ContactUseCase({required this.contactoRepository});

  Future<void> call(Contacto contact) async {
    await contactoRepository.addContact(contact);
  }

  Future<Contacto?> callScan(String contact) async {
    return await contactoRepository.scanQr(contact);
  }
}
