import 'package:casino_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterPageState extends Equatable {
  final bool isFetching;

  CharacterPageState(this.isFetching);

  @override
  List<Object?> get props => [
    isFetching,
  ];
}

class InitialMainPageState extends CharacterPageState {
  final bool isFetching;

  InitialMainPageState({this.isFetching = false}) : super(false);

  @override
  List<Object> get props => [isFetching];
}

class InitialLoadingMainPageState extends CharacterPageState {
  final bool isFetching;

  InitialLoadingMainPageState({this.isFetching = true}) : super(false);

  @override
  List<Object> get props => [isFetching];
}

class InitialUnsuccessfulState extends CharacterPageState {
  final bool isFetching;

  InitialUnsuccessfulState({this.isFetching = false}) : super(false);

  @override
  List<Object> get props => [isFetching];
}

class LoadMoreUnsuccessfulState extends CharacterPageState {
  final bool isFetching;

  LoadMoreUnsuccessfulState({this.isFetching = false}) : super(false);

  @override
  List<Object> get props => [isFetching];
}

class SuccessfulPageState extends CharacterPageState {
  final List<Character> charactersList;

  SuccessfulPageState(this.charactersList, {bool isFetching = false}) : super(false);

  @override
  List<Object> get props => [charactersList];
}

class NextPageLoadingState extends CharacterPageState {
  final bool isFetching;

  NextPageLoadingState({this.isFetching = true}) : super(false);

  @override
  List<Object> get props => [isFetching];
}
