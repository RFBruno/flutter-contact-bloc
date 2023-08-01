import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';

class BlocExample extends StatelessWidget {
  const BlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),
      body: BlocBuilder<ExampleBloc, ExampleState>(
        builder: (context, state) {
          if (state is ExampleStateData) {
            return ListView.builder(
              itemCount: state.names.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15,),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      state.names[index],
                    ),
                  ),
                );
              },
            );
          }

          return const Text('Nada encontrado');
        },
      ),
    );
  }
}
