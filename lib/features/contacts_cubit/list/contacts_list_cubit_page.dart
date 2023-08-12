import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/list/cubit/contacts_list_cubit.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/widgets/loader.dart';

import '../../../listener_desafio/util_success_error.dart';

class ContactsListCubitPage extends StatelessWidget {
  const ContactsListCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts Cubit'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final contact = ContactModel(name: 'Aleatorio', email: 'aleatorio@email.com');
        context.read<ContactsListCubit>().insert(contact);
      },
      child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ContactsListCubit>().findAll(),
        child: BlocListener<ContactsListCubit, ContactsListCubitState>(
          listenWhen: (previous, current) {
            return current.maybeWhen(
              error: (_) => true,
              orElse: () => false,
            );
          },
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => utilError(context, message),
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactsListCubit, ContactsListCubitState>(
                      selector: (state) {
                        return state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                      },
                    ),
                    BlocSelector<ContactsListCubit, ContactsListCubitState,
                        List<ContactModel>>(
                      selector: (state) {
                        return state.maybeWhen(
                          data: (contacts) => contacts,
                          orElse: () => <ContactModel>[],
                        );
                      },
                      builder: (_, contacts) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              onLongPress: () {
                                context
                                    .read<ContactsListCubit>()
                                    .delete(contact);
                              },
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
