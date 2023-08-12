import 'package:bloc/bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_register_cubit_state.dart';
part 'contacts_register_cubit.freezed.dart';

class ContactsRegisterCubit extends Cubit<ContactsRegisterCubitState> {
  final ContactsRespository _respository;

  ContactsRegisterCubit({required ContactsRespository respository})
      : _respository = respository,
        super(const ContactsRegisterCubitState.initial());

  save(ContactModel contact) async {
    try {
      emit(const ContactsRegisterCubitState.loading());
      await _respository.create(contact);
      await Future.delayed(const Duration(seconds: 2));
      emit(const ContactsRegisterCubitState.success());
    } catch (e) {
      emit(
        const ContactsRegisterCubitState.error(
            message: 'Errou ao tentar salvar o contato'),
      );
    }
  }
}
