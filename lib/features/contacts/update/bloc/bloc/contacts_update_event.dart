part of 'contacts_update_bloc.dart';

@freezed
class ContactsUpdateEvent with _$ContactsUpdateEvent {
  const factory ContactsUpdateEvent.save({
    required int id,
    required String name,
    required String email,
  }) = _Save;
}