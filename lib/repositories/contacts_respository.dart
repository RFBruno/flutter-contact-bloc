
import 'package:dio/dio.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';

class ContactsRespository {
  

  static const API_URL = 'http://10.0.2.2:8080';
  
  Future<List<ContactModel>> findAll() async{
    final dio = Dio();
    final response = await dio.get('$API_URL/contacts');
  
    return response.data?.map<ContactModel>(
      (contact) => ContactModel.fromMap(contact)
    ).toList();
  }

  Future<void> create(ContactModel model) async {
    final dio = Dio(
    );
    await dio.post('$API_URL/contacts', data: model.toMap());

  }

  Future<void> update(ContactModel model) => 
    Dio().put('$API_URL/contacts/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) =>
    Dio().delete('$API_URL/contacts/${model.id}');
}