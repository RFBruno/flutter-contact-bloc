import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_list_cubit_state.dart';
part 'contacts_list_cubit.freezed.dart';

class ContactsListCubit extends Cubit<ContactsListCubitState> {
  final ContactsRespository _respository;
  ContactsListCubit({required ContactsRespository respository})
      : _respository = respository,
        super(ContactsListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(ContactsListCubitState.loading());
      final contacts = await _respository.findAll();
      await Future.delayed(const Duration(seconds: 2));
      
      emit(ContactsListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar contatos findAll', error: e, stackTrace: s);
      emit(
        ContactsListCubitState.error(
            message: 'Erro ao buscar lista de contatos'),
      );
    }
  }

  insert(ContactModel contact) async {
    try {
      emit(ContactsListCubitState.loading());
      await _respository.create(contact);
      findAll();
    } catch (e, s) {
      log('Errou ao adicionar um contato insert', error: e, stackTrace: s);
      emit(ContactsListCubitState.error(message: 'Erro ao tentar adicionar um novo contato'),);
    }
  }

  delete(ContactModel contact) async {
    try {
      emit(ContactsListCubitState.loading());
      await _respository.delete(contact);
      findAll();
    } catch (e, s) {
      log('Erro ao tentar deletar delete', error: e, stackTrace: s);
      emit(
        ContactsListCubitState.error(
            message: 'Errou ao tentar deletar o contato'),
      );
      findAll();
    }
  }
}
