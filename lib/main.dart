import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_freezed_example.dart';
import 'package:flutter_counter_bloc/features/contacts/list/bloc/contacts_list_bloc.dart';
import 'package:flutter_counter_bloc/features/contacts/list/contacts_list_page.dart';
import 'package:flutter_counter_bloc/features/contacts/register/contacts_register_page.dart';
import 'package:flutter_counter_bloc/features/contacts/update/contacts_update_page.dart';
import 'package:flutter_counter_bloc/home/home_page.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example.dart';
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
                  contactsRespository: context.read<ContactsRespository>()
                )..add(
                  const ContactsListEvent.findAll()
                ),
                child: const ContactsListPage(),
              ),
          '/contacts/register' : (_) => const ContactsRegisterPage(),
          '/contacts/update' :(_) => const ContactsUpdatePage()
        },
      ),
    );
  }
}
