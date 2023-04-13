import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/repositories/contacto_repository.dart';

class ContactRepositoryImpl implements ContactoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addContact(Contacto contact) async {
    final userCollection = _firestore.collection('contactos');
    await userCollection.add({
      'name': contact.nombre,
      'telefono': contact.telefono,
    });
  }

  @override
  Future<void> updateContact(Contacto contact) async {
    // final userDoc = firestore.collection('contactos').doc(contact.id);
    // await userDoc.update({
    //   'name': user.name,
    //   'age': user.age,
    // });
  }

  @override
  Future<void> deleteContact(Contacto contact) async {
    final userDoc = _firestore.collection('contactos').doc(contact.id);
    await userDoc.delete();
  }

  @override
  Future<List<Contacto>> getContacts() async {
    final userCollection = _firestore.collection('contactos');
    final queryContact = await userCollection.get();
    return queryContact.docs.map((doc) {
      final data = doc.data();
      return Contacto.fromJson(data);
    }).toList();
  }

  @override
  Future<Contacto?> scanQr(String qrstr) async {
    if (qrstr.isNotEmpty) {
      Map<String, dynamic> mapa = Map.fromEntries(qrstr.split(',').map((s) {
        final List<String> parts = s.trim().split(':');
        return MapEntry(parts[0], parts[1]);
      }));

      // Crear un nuevo objeto de la clase Contacto a partir del mapa
      return Contacto.fromJson(mapa);
      // Parsear el mensaje para obtener un mapa
    } else {
      return null;
    }
  }
}
