import 'package:bloc/bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/update/bloc/bloc/contacts_update_bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_update_cubit_state.dart';
part 'contacts_update_cubit.freezed.dart';

class ContactsUpdateCubit extends Cubit<ContactsUpdateCubitState> {
  final ContactsRespository _respository;
  ContactsUpdateCubit({required ContactsRespository respository})
      : _respository = respository,
        super(const ContactsUpdateCubitState.initial());

  update(ContactModel contact) async {
    try {
      emit(const ContactsUpdateCubitState.loading());
      
      await _respository.update(contact);
      await Future.delayed(const Duration(seconds: 2));
      emit(const ContactsUpdateCubitState.success());
    } catch (e) {
      emit(
        const ContactsUpdateCubitState.error(message : 'Erro ao tentar atualizar o contanto'),
      );
    }
  }
}
