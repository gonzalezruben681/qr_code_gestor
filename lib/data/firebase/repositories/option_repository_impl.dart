import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/domain/repositories/opcion_repository.dart';

class OptionRepositoryImpl extends OptionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<bool> addOption(String option) async {
    final userCollection = _firestore.collection('opciones');
    try {
      await userCollection.add({
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
  Future<void> deleteOption(OptionModel option) {
    // TODO: implement deleteOption
    throw UnimplementedError();
  }

  @override
  Stream<List<OptionModel>> getOptions() {
    final optionsCollection = _firestore.collection('opciones');
    return optionsCollection.snapshots().map((optionsSnapshot) =>
        optionsSnapshot.docs
            .map((doc) => OptionModel.fromJson({'id': doc.id, ...doc.data()}))
            .toList());
  }

  // @override
  // Future<List<OptionModel>> getOptions() async {
  //   // List<OptionModel> options = [];
  //   final optionsCollection = _firestore.collection('opciones');
  //   final optionsSnapshot = await optionsCollection.get();

  //   final optionsList = optionsSnapshot.docs
  //       .map((doc) => OptionModel.fromJson({'id': doc.id, ...doc.data()}))
  //       .toList();

  //   return optionsList;
  // }

  @override
  Future<void> updateOption(OptionModel option) {
    // TODO: implement updateOption
    throw UnimplementedError();
  }
}
