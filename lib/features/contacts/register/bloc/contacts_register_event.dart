part of 'contacts_register_bloc.dart';

@freezed
class ContactsRegisterEvent with _$ContactsRegisterEvent{

  const factory ContactsRegisterEvent.save({
    required String name,
    required String email
  }) = _Save;
  
}