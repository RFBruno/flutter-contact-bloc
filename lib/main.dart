import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_freezed_example.dart';
import 'package:flutter_counter_bloc/features/contacts/list/bloc/contacts_list_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/list/contacts_list_page.dart';
import 'package:flutter_counter_bloc/features/contacts/register/bloc/contacts_register_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/register/contacts_register_page.dart';
import 'package:flutter_counter_bloc/features/contacts/update/bloc/bloc/contacts_update_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/update/contacts_update_page.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/list/contacts_list_cubit_page.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/list/cubit/contacts_list_cubit.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/register/contacts_register_cubit_page.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/register/cubit/contacts_register_cubit.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/uplade/contacts_update_cubit_page.dart';
import 'package:flutter_counter_bloc/features/contacts_cubit/uplade/cubit/contacts_update_cubit.dart';
import 'package:flutter_counter_bloc/home/home_page.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example.dart';
import 'package:flutter_counter_bloc/models/contact_model.dart';
import 'package:flutter_counter_bloc/repositories/contacts_respository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRespository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue.shade900,
          ),
          useMaterial3: true,
        ),
        routes: {
          '/': (_) => const HomePage(),
          '/bloc/example': (_) => BlocProvider(
                create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
                child: const BlocExample(),
              ),
          '/bloc/example/freezed': (_) => BlocProvider(
                create: (_) => ExampleFreezedBloc()
                  ..add(
                    const ExampleFreezedEvent.findNames(),
                  ),
                child: const BlocFreezedExample(),
              ),
          '/contacts/list': (_) => BlocProvider(
                create: (context) => ContactsListBloc(
                    contactsRespository: context.read<ContactsRespository>())
                  ..add(const ContactsListEvent.findAll()),
                child: const ContactsListPage(),
              ),
          '/contacts/register': (_) => BlocProvider(
              create: (context) {
                return ContactsRegisterBloc(
                  contactsRespository: context.read(),
                );
              },
              child: const ContactsRegisterPage()),
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;
            return BlocProvider(
              create: (context) => ContactsUpdateBloc(
                contactsRespository: context.read(),
              ),
              child: ContactsUpdatePage(
                model: contact,
              ),
            );
          },
          '/contacts/cubit/list': (_) {
            return BlocProvider<ContactsListCubit>(
              create: (context) {
                return ContactsListCubit(respository: context.read())
                  ..findAll();
              },
              child: const ContactsListCubitPage(),
            );
          },
          '/contacts/cubit/register': (_) {
            return BlocProvider<ContactsRegisterCubit>(
              create: (context) {
                return ContactsRegisterCubit(
                  respository: context.read(),
                );
              },
              child: const ContactsRegisterCubitPage(),
            );
          },
          '/contacts/cubit/update': (context) {
            final contact = ModalRoute.of(context)?.settings.arguments as ContactModel;
            return BlocProvider(
              create: (context) {
                return ContactsUpdateCubit(
                  respository: context.read(),
                );
              },
              child: ContactsUpdateCubitPage(contact: contact),
            );
          }
        },
      ),
    );
  }
}
