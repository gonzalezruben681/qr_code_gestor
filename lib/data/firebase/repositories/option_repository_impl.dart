import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/domain/repositories/opcion_repository.dart';

class OptionRepositoryImpl extends OptionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<bool> addOption(String option) async {
    final optionsCollection = _firestore.collection('opciones');
    try {
      await optionsCollection.add({
        'opcion': option,
      });
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteOption(OptionModel option) async {
    final optionsCollection = _firestore.collection('opciones');
    try {
      await optionsCollection.doc(option.id).delete();
      return true;
    } on FirebaseException {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<List<OptionModel>> getOptions() {
    final optionsCollection = _firestore.collection('opciones');
    return optionsCollection.snapshots().map((optionsSnapshot) =>
        optionsSnapshot.docs
            .map((doc) => OptionModel.fromJson({'id': doc.id, ...doc.data()}))
            .toList());
  }

  @override
  Future<void> updateOption(OptionModel option) async {
    final userCollection = _firestore.collection('opciones');
    await userCollection.doc(option.id).update({'opcion': option.option});
  }
}
