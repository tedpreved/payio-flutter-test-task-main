import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc.dart';
import 'package:casino_test/src/presentation/bloc/character_event.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'src/presentation/bloc/character_state.dart';

void main() {
  MainDIModule.init(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      home: BlocProvider(
        create: (context) => CharactersBloc(
          InitialMainPageState(),
          GetIt.I.get<CharactersRepository>(),
        )..add(
            const GetInitialDataEvent(1),
          ),
        child: CharactersScreen(
          key: const Key("characters_screen"),
        ),
      ),
    );
  }
}
