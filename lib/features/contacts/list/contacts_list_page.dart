import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/list/bloc/contacts_list_bloc.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/widgets/loader.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/contacts/register');
          context
              .read<ContactsListBloc>()
              .add(const ContactsListEvent.findAll());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactsListBloc, ContactsListState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            error: (error) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                  backgroundColor: Colors.red.shade200,
                ),
              );
            },
          );
        },
        child: RefreshIndicator(
          onRefresh: () async => context.read<ContactsListBloc>()
            ..add(const ContactsListEvent.findAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(children: [
                  Loader<ContactsListBloc, ContactsListState>(
                    selector: (state) {
                      return state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                    },
                  ),
                  BlocSelector<ContactsListBloc, ContactsListState,
                      List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => [],
                      );
                    },
                    builder: (_, contacts) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return Dismissible(
                            key: Key(index.toString()),
                            background: Container(
                              color: Colors.red.shade200,
                            ),
                            onDismissed: (direction) {
                              context.read<ContactsListBloc>().add(
                                  ContactsListEvent.delete(model: contact));
                              context
                                  .read<ContactsListBloc>()
                                  .add(const ContactsListEvent.findAll());
                            },
                            child: ListTile(
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                    '/contacts/update',
                                    arguments: contact);
                                if (context.mounted) {
                                  context
                                      .read<ContactsListBloc>()
                                      .add(const ContactsListEvent.findAll());
                                }
                              },
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
