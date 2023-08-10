import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_register_state.dart';
part 'contacts_register_event.dart';
part 'contacts_register_bloc.freezed.dart';

class ContactsRegisterBloc
    extends Bloc<ContactsRegisterEvent, ContactsRegisterState> {
  final ContactsRespository _contactsRespository;

  ContactsRegisterBloc({required ContactsRespository contactsRespository})
      : _contactsRespository = contactsRespository,
        super(const ContactsRegisterState.intial()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(_Save event, Emitter<ContactsRegisterState> emit) async {
    
    try {
  emit(const ContactsRegisterState.loading());
  
  await Future.delayed(const Duration(seconds: 2));
  
  final contactModel = ContactModel(
    name: event.name,
    email: event.email,
  );
  
  await _contactsRespository.create(contactModel);
  emit(const ContactsRegisterState.success());
}  catch (e) {
  emit(const ContactsRegisterState.error(message: 'Erro ao salvar um novo contato'));
  
}
  }
}
