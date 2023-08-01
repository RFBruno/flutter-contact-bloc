import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/example_bloc_cubit/home_page.dart';
import 'package:flutter_counter_bloc/example_bloc_cubit/page_bloc/bloc/counter_bloc.dart';
import 'package:flutter_counter_bloc/example_bloc_cubit/page_bloc/counter_bloc_page.dart';
import 'package:flutter_counter_bloc/example_bloc_cubit/page_cubit/counter_cubit_page.dart';
import 'package:flutter_counter_bloc/example_bloc_cubit/page_cubit/cubit/counter_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal.shade300,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/bloc': (_) => BlocProvider(
              create: (_) => CounterBloc(),
              child: const CounterBlocPage(),
            ),
        '/cubit': (_) => BlocProvider(
              create: (_) => CounterCubit(),
              child: const CounterCubitPage(),
            )
      },
    );
  }
}
