import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';
part 'contacts_list_bloc.freezed.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  final ContactsRespository _respository;
  ContactsListBloc({required ContactsRespository contactsRespository})
      : _respository = contactsRespository,
        super(ContactsListState.initial()) {
    on<_ContactsListEventFindAll>(_findAll);
    on<_ContactsListEventDelete>(_delete);
  }

  Future<void> _findAll(
      _ContactsListEventFindAll event, Emitter<ContactsListState> emit) async {
    try {
      emit(ContactsListState.loading());

      final contacts = await _respository.findAll();
      await Future.delayed(const Duration(seconds: 2));

      emit(ContactsListState.data(contacts: contacts));
    } catch (e, s) {
      log('Errou ao buscar contatos', error: e, stackTrace: s);
      emit(ContactsListState.error(error: 'Errou ao buscar contatos'));
    }
  }

  Future<FutureOr<void>> _delete(
      _ContactsListEventDelete event, Emitter<ContactsListState> emit) async {
    try {
      emit(ContactsListState.loading());
      await _respository.delete(event.model);

      
    } catch (e) {
      emit(ContactsListState.error(error: 'Erro ao delete contato'));
    }
  }
}
