import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/uplade/cubit/contacts_update_cubit.dart';
import 'package:flutter_counter_bloc/listener_desafio/util_success_error.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/widgets/loader.dart';

class ContactsUpdateCubitPage extends StatefulWidget {
  final ContactModel contact;
  const ContactsUpdateCubitPage({required this.contact, super.key});

  @override
  State<ContactsUpdateCubitPage> createState() =>
      _ContactsUpdateCubitPageState();
}

class _ContactsUpdateCubitPageState extends State<ContactsUpdateCubitPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameEC;
  late TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();

    _nameEC = TextEditingController(text: widget.contact.name);
    _emailEC = TextEditingController(text: widget.contact.email);
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
        title: const Text('Update Cubit'),
      ),
      body: BlocListener<ContactsUpdateCubit, ContactsUpdateCubitState>(
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
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                TextFormField(
                  controller: _emailEC,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final valid = _formKey.currentState?.validate() ?? false;

                    if (valid) {
                      final contact = ContactModel(
                        id: widget.contact.id,
                        name: _nameEC.text,
                        email: _emailEC.text,
                      );
                      context.read<ContactsUpdateCubit>().update(contact);
                    }
                  },
                  child: const Text('Atualizar'),
                ),
                Loader<ContactsUpdateCubit, ContactsUpdateCubitState>(
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
