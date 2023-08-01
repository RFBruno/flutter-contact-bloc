import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/home/home_page.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc_example.dart';
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
          seedColor: Colors.blue.shade900,
        ),
        useMaterial3: true,
      ),
      routes: {
        '/' : (_) => const HomePage(),
        '/bloc/example': (_) => BlocProvider(
          create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
          child: const BlocExample(),
        )
      },
    );
  }
}
