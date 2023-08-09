import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_freezed/example_freezed_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context
                .read<ExampleFreezedBloc>()
                .add(const ExampleFreezedEvent.addName('New name'));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Example Freezed'),
        ),
        // Só para escutar algo no state
        body: BlocListener<ExampleFreezedBloc, ExampleFreezedState>(
          listener: (context, state) {
            state.whenOrNull(
              showBanner: (_, message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              BlocSelector<ExampleFreezedBloc, ExampleFreezedState, bool>(
                selector: (state) {
                  return state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                },
                builder: (_, showLoader) {
                  return Visibility(
                    visible: showLoader,
                    child: const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
              BlocSelector<ExampleFreezedBloc, ExampleFreezedState,
                  List<String>>(
                selector: (state) {
                  return state.maybeWhen(
                    data: (names) => names,
                    showBanner: (names, _) => names,
                    orElse: () => <String>[],
                  );
                },
                builder: (_, names) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: names.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        title: Text(names[index]),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}
