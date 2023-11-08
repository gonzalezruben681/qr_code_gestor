// Injeccion de dependencias
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_gestor/data/firebase/repositories/contact_repository_impl.dart';
import 'package:qr_code_gestor/domain/usecases/contacto_usecase.dart';

final contactProvider = Provider<ContactUseCase>(
    (ref) => ContactUseCase(contactoRepository: ContactRepositoryImpl()));

final contactDataProvider = StateProvider((ref) => '');

// class ContactDataState {
//   final String text;

//   ContactDataState({this.text = ''});

//   ContactDataState copyWith({String? text}) =>
//       ContactDataState(text: text ?? this.text);
// }

// class ContactDataNotifier extends StateNotifier<ContactDataState> {
//   ContactDataNotifier() : super(ContactDataState());

//   void data(String data) {
//     state = state.copyWith(text: data);
//   }

//   void reset() {
//     state = ContactDataState();
//   }
// }

// final contactDataProvider =
//     StateNotifierProvider<ContactDataNotifier, ContactDataState>(
//   (ref) => ContactDataNotifier(),
// );
