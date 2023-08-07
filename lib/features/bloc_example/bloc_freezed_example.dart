import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/features/bloc_example/bloc/example_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ExampleBloc>().add(ExampleAddNameEvent());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Bloc Example Freezed'),
      ),
      // Só para escutar algo no state
      body: BlocListener<ExampleBloc, ExampleState>(
        listenWhen: (previous, current) {
          if (previous is ExampleStateInitial && current is ExampleStateData) {
            if (current.names.length > 3) {
              return true;
            }
          }
          return false;
        },
        listener: (context, state) {
          if (state is ExampleStateData) {
            var message = ScaffoldMessenger.of(context);
            message.clearSnackBars();
            message.showSnackBar(
              SnackBar(
                content: Text('Quantidade de nomes é ${state.names.length}'),
              ),
            );
          }
        },
        child: Column(
          children: [
            //builda a tela e escuta as mudanças
            BlocConsumer<ExampleBloc, ExampleState>(
              listenWhen: (previous, current) {
                if (previous is ExampleStateInitial &&
                    current is ExampleStateData) {
                  if (current.names.length > 3) {
                    return true;
                  }
                }
                return false;
              },
              listener: (context, state) {
                print('Estado alterado para ${state.runtimeType}');
              },
              builder: (_, state) {
                if (state is ExampleStateData) {
                  return Text('Total de nomes é ${state.names.length}');
                }

                return const SizedBox.shrink();
              },
            ),
            // pode ser usado para tratar algo espcifico evitando uso de logica no builder
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }

                return false;
              },
              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleStateData) {
                  return state.names;
                }
                return [];
              },
              builder: (context, names) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ExampleBloc>().add(
                              ExampleRemoveNameEvent(
                                name: names[index],
                              ),
                            );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 15,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            names[index],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // BlocBuilder<ExampleBloc, ExampleState>(
            //   builder: (context, state) {
            //     if (state is ExampleStateData) {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: state.names.length,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             margin: const EdgeInsets.symmetric(
            //               vertical: 4,
            //               horizontal: 15,
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.all(10),
            //               child: Text(
            //                 state.names[index],
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }

            //     return const Text('Nada encontrado');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
