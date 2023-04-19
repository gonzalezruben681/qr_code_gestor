import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_gestor/data/firebase/repositories/option_repository_impl.dart';
import 'package:qr_code_gestor/domain/usecases/option_usecase.dart';

final optionProvider = Provider<OptionUsecase>(
    (ref) => OptionUsecase(optionRepository: OptionRepositoryImpl()));
