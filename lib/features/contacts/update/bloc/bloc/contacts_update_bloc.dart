// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';

part 'contacts_update_bloc.freezed.dart';
part 'contacts_update_event.dart';
part 'contacts_update_state.dart';

class ContactsUpdateBloc
    extends Bloc<ContactsUpdateEvent, ContactsUpdateState> {
  final ContactsRespository _contactsRespository;

  ContactsUpdateBloc(
    {required ContactsRespository contactsRespository}
  )   : _contactsRespository = contactsRespository,
        super(const _Initial()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      _Save event, Emitter<ContactsUpdateState> emit) async {
    try {
      emit(const ContactsUpdateState.loading());

      final model = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );
      await _contactsRespository.update(model);
      emit(const ContactsUpdateState.success());
    } catch (e, s) {
      log('Erro ao atualizar o contato', error: e, stackTrace: s);
      emit(
        const ContactsUpdateState.error(message: 'Erro ao atualizar o contato'), 
      );
    }
  }
}
