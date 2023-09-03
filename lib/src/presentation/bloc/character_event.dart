import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/response/character_response.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterPageEvent extends Equatable {
  const CharacterPageEvent();

  @override
  List<Object?> get props => [];
}

class GetInitialDataEvent extends CharacterPageEvent {
  final int page;

  const GetInitialDataEvent(this.page);

  @override
  List<Object?> get props => [];
}

class LoadingDataOnMainPageEvent extends CharacterPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadNextPageOnMainPageEvent extends CharacterPageEvent {
  const LoadNextPageOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends CharacterPageEvent {
  final List<Character>? charactersList;

  const DataLoadedOnMainPageEvent(this.charactersList);

  @override
  List<Object?> get props => [charactersList];
}
