// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/update/bloc/bloc/contacts_update_bloc.dart';
import 'package:flutter_counter_bloc/listener_desafio/util_success_error.dart';

import 'package:flutter_counter_bloc/models/contact_model.dart';

import '../../../widgets/loader.dart';

class ContactsUpdatePage extends StatefulWidget {
  final ContactModel model;
  const ContactsUpdatePage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ContactsUpdatePage> createState() => _ContactsUpdatePageState();
}

class _ContactsUpdatePageState extends State<ContactsUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.model.name);
    _emailEC = TextEditingController(text: widget.model.email);
  }

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: BlocListener<ContactsUpdateBloc, ContactsUpdateState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () => utilSuccess(context),
            error: (message) => utilError(context, message),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(label: Text('Nome')),
                  validator: (value) {
                    if (value == '') {
                      return 'Nome obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailEC,
                  decoration: const InputDecoration(label: Text('E-mail')),
                  validator: (value) {
                    if (value == '') {
                      return 'E-mail obrigatório';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final valid = _formKey.currentState?.validate() ?? false;

                    if (valid) {
                      context.read<ContactsUpdateBloc>().add(
                            ContactsUpdateEvent.save(
                              id: widget.model.id!,
                              name: _nameEC.text,
                              email: _emailEC.text,
                            ),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactsUpdateBloc, ContactsUpdateState>(
                  selector: (state) {
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
