import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactRepositoryImpl implements ContactoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addContact(ContactoModel contact) async {
    final userCollection = _firestore.collection('contactos');
    await userCollection.add({
      'nombre': contact.nombre,
      'telefono': contact.telefono,
      'id_opcion': contact.idOpcion
    });
  }

  @override
  Future<void> updateContact(ContactoModel contact) async {
    final userCollection = _firestore.collection('contactos');
    await userCollection
        .doc(contact.id)
        .update({'nombre': contact.nombre, 'telefono': contact.telefono});
  }

  @override
  Future<bool> deleteContact(ContactoModel contact) async {
    final optionsCollection = _firestore.collection('contactos');
    try {
      await optionsCollection.doc(contact.id).delete();
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<List<ContactoModel>> getContacts() {
    final userCollection = _firestore.collection('contactos');
    final stream = userCollection.snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => ContactoModel.fromJson({'id': doc.id, ...doc.data()}))
        .toList());
  }
}
