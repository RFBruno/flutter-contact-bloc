import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/register/cubit/contacts_register_cubit.dart';
import 'package:flutter_counter_bloc/listener_desafio/util_success_error.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/widgets/loader.dart';

class ContactsRegisterCubitPage extends StatefulWidget {
  const ContactsRegisterCubitPage({super.key});

  @override
  State<ContactsRegisterCubitPage> createState() =>
      _ContactsRegisterCubitPageState();
}

class _ContactsRegisterCubitPageState extends State<ContactsRegisterCubitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

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
        title: const Text('Register Cubit'),
      ),
      body: BlocListener<ContactsRegisterCubit, ContactsRegisterCubitState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (_) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            error: (message) => utilError(context, message),
            success: () => utilSuccess(context),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  validator: (value) {
                    return value!.isEmpty ? 'Campo obrigatório' : null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailEC,
                  validator: (value) {
                    return value!.isEmpty ? 'Campo obrigatório' : null;
                  },
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    final valid = _formKey.currentState?.validate() ?? false;
                    if (valid) {
                      final contact = ContactModel(
                        name: _nameEC.text,
                        email: _emailEC.text,
                      );
                      context.read<ContactsRegisterCubit>().save(contact);
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactsRegisterCubit, ContactsRegisterCubitState>(
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
