import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactRepositoryImpl implements ContactoRepository {
  final FirebaseFirestore firestore;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  ContactRepositoryImpl({required this.firestore});

  @override
  Future<void> addContact(Contacto contact) async {
    final userCollection = firestore.collection('contactos');
    await userCollection.add({
      'name': contact.nombre,
      'telefono': contact.telefono,
    });
  }

  @override
  Future<void> updateContact(Contacto contact) async {
    final userDoc = firestore.collection('contactos').doc(contact.id);
    // await userDoc.update({
    //   'name': user.name,
    //   'age': user.age,
    // });
  }

  @override
  Future<void> deleteContact(Contacto contact) async {
    final userDoc = firestore.collection('contactos').doc(contact.id);
    await userDoc.delete();
  }

  @override
  Future<List<Contacto>> getContacts() async {
    final userCollection = firestore.collection('contactos');
    final queryContact = await userCollection.get();
    return queryContact.docs.map((doc) {
      final data = doc.data();
      return Contacto.fromJson(data);
    }).toList();
  }
}
