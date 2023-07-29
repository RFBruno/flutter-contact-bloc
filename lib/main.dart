import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/home_page.dart';
import 'package:flutter_counter_bloc/page_bloc/bloc/counter_bloc.dart';
import 'package:flutter_counter_bloc/page_bloc/counter_bloc_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: const CounterBlocPage()
          ),
      },
    );
  }
}
