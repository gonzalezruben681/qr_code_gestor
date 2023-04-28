import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/domain/repositories/opcion_repository.dart';

class OptionUsecase {
  final OptionRepository optionRepository;

  OptionUsecase({required this.optionRepository});

  Future<bool> addOption(String option) async {
    return await optionRepository.addOption(option);
  }

  Stream<List<OptionModel>> getOptions() async* {
    yield* optionRepository.getOptions();
  }

  Future<void> updateOption(OptionModel option) async {
    return await optionRepository.updateOption(option);
  }

  Future<bool> deleteOption(OptionModel option) async {
    return await optionRepository.deleteOption(option);
  }
}
