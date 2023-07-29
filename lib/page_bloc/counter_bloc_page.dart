import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/page_bloc/bloc/counter_bloc.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Bloc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  'Counter ${state.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(
                      CounterIncrement()
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(
                      CounterDecrement()
                    );
                  },
                  icon: const Icon(Icons.remove),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
