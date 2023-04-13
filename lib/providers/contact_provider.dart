// Injeccion de dependencias
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_gestor/data/firebase/repositories/contact_repository_impl.dart';
import 'package:qr_code_gestor/domain/usecases/contacto_usecase.dart';

final contactProvider = Provider<ContactUseCase>(
    (ref) => ContactUseCase(contactoRepository: ContactRepositoryImpl()));

final contactDataProvider = StateProvider((ref) => '');
