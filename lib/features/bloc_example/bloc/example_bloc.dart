import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removeName);
    on<ExampleAddNameEvent>(_addName);
  }

  FutureOr<void> _removeName(
      ExampleRemoveNameEvent event, Emitter<ExampleState> emit) {
    final stateExample = state;

    if (stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      names.retainWhere((element) => element != event.name);

      emit(ExampleStateData(names: names));
    }
  }

  FutureOr<void> _addName( ExampleAddNameEvent event, Emitter<ExampleState> emit) {
    final stateExample = state;
    if (stateExample is ExampleStateData) {
      final names = [...stateExample.names];
      names.add('Novo nome ${Random().nextInt(100)}');

      emit(ExampleStateData(names:names));
    }
  }

  FutureOr<void> _findNames(
      ExampleEvent event, Emitter<ExampleState> emit) async {
    final names = [
      'Rodrigo Rahman',
      'Academia do Flutter',
      'Flutter',
      'Dart',
      'Flutter Bloc',
      'Bruno Rafael'
    ];
    await Future.delayed(
      Duration(seconds: 1),
    );
    emit(ExampleStateData(names: names));
  }
}
