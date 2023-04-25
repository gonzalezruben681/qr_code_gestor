import 'package:qr_code_gestor/domain/models/contacto.dart';

abstract class ContactoRepository {
  Future<void> addContact(ContactoModel contact);
  Future<void> updateContact(ContactoModel contact);
  Future<void> deleteContact(ContactoModel contact);
  Stream<List<ContactoModel>> getContacts();
  Future<ContactoModel?> scanQr(String qrstr);
}
