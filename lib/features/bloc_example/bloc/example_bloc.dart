import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc  extends Bloc<ExampleEvent, ExampleState>{

  ExampleBloc(): super(ExampleStateInitial()){
    on<ExampleFindNameEvent>(_findNames);
  }
  

  FutureOr<void> _findNames(ExampleEvent event, Emitter<ExampleState> emit) async{
    final names = [
      'Rodrigo Rahman',
      'Academia do Flutter',
      'Flutter',
      'Dart',
      'Flutter Bloc',
      'Bruno Rafael'
    ];

    emit(ExampleStateData(names: names));
  }
}