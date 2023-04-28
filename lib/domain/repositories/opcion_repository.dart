import 'package:qr_code_gestor/domain/models/opcion.dart';

abstract class OptionRepository {
  Future<bool> addOption(String option);
  Future<void> updateOption(OptionModel option);
  Future<bool> deleteOption(OptionModel option);
  Stream<List<OptionModel>> getOptions();
}
