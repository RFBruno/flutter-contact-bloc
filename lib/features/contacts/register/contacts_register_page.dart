import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/list/bloc/contacts_list_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/register/bloc/contacts_register_bloc.dart';
import 'package:flutter_counter_bloc/widgets/loader.dart';

class ContactsRegisterPage extends StatefulWidget {
  const ContactsRegisterPage({super.key});

  @override
  State<ContactsRegisterPage> createState() => _ContactsRegisterPageState();
}

class _ContactsRegisterPageState extends State<ContactsRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<ContactsRegisterBloc, ContactsRegisterState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (message) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            success: () => Navigator.of(context).pop(),
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red.shade200,
                ),

              );
            },
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
                      context.read<ContactsRegisterBloc>().add(
                            ContactsRegisterEvent.save(
                              name: _nameEC.text,
                              email: _emailEC.text,
                            ),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactsRegisterBloc, ContactsRegisterState>(
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
