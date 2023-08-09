import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_freezed_state.dart';
part 'example_freezed_event.dart';
part 'example_freezed_bloc.freezed.dart';

class ExampleFreezedBloc
    extends Bloc<ExampleFreezedEvent, ExampleFreezedState> {
  ExampleFreezedBloc() : super(const ExampleFreezedState.initial()) {
    on<_ExampleFreezedEventFindNames>(_findNames);
    on<_ExampleFreezedEventAddName>(_addName);
    on<_ExampleFreezedEventRemoveName>(_removeName);
  }

  FutureOr<void> _removeName(
      _ExampleFreezedEventRemoveName event, Emitter<ExampleFreezedState> emit) {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );

    final newNames = [...names];
    newNames.retainWhere((element) => element != event.name);

    emit(ExampleFreezedState.data(names: newNames));
  }

  Future<FutureOr<void>> _addName(_ExampleFreezedEventAddName event,
      Emitter<ExampleFreezedState> emit) async {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );

    emit(
      ExampleFreezedState.showBanner(
          names: names, message: 'Nome sendo inserido'),
    );

    await Future.delayed(const Duration(seconds: 2));

    final newNames = [...names];

    newNames.add('${event.name} ${Random().nextInt(100)}');

    emit(ExampleFreezedState.data(names: newNames));
  }

  FutureOr<void> _findNames(_ExampleFreezedEventFindNames event,
      Emitter<ExampleFreezedState> emit) async {
    emit(const ExampleFreezedState.loading());

    final names = [
      'Rodrigo Rahman',
      'Academia do Flutter',
      'Flutter',
      'Dart',
      'Flutter Bloc',
      'Bruno Rafael'
    ];
    await Future.delayed(
      const Duration(seconds: 1),
    );
    emit(ExampleFreezedState.data(names: names));
  }
}
