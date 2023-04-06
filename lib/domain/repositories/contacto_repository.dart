import 'package:qr_code_gestor/domain/models/contacto.dart';

abstract class ContactoRepository {
  Future<void> addContact(Contacto contact);
  Future<void> updateContact(Contacto contact);
  Future<void> deleteContact(Contacto contact);
  Future<List<Contacto>> getContacts();
}
