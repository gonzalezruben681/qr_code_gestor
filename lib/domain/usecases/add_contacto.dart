import 'package:qr_code_gestor/domain/models/contacto.dart';

import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class AddContactUseCaseImpl {
  final ContactoRepository contactoRepository;

  AddContactUseCaseImpl({required this.contactoRepository});

  Future<void> call(Contacto contact) async {
    await contactoRepository.addContact(contact);
  }
}
