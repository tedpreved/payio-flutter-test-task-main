import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/character_event.dart';
import 'package:casino_test/src/presentation/bloc/character_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersBloc extends Bloc<CharacterPageEvent, CharacterPageState> {
  final CharactersRepository _charactersRepository;
  List<Character> _characters = List.empty(growable: true);

  CharactersBloc(
    CharacterPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetInitialDataEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(InitialLoadingMainPageState()),
    );
    on<LoadNextPageOnMainPageEvent>(
      (event, emitter) => _loadNextPagePage(emitter),
    );
  }

  Future<void> _loadNextPagePage(Emitter<CharacterPageState> emit) async {
    emit(NextPageLoadingState());
    try {
      var data = await _charactersRepository.loadNextPage();
      if (data == null || data.isEmpty) {
        emit(SuccessfulPageState(_characters));
        return;
      }

      _characters.clear();
      _characters.addAll(data);

      emit(SuccessfulPageState(_characters));
    } catch (e) {
      print(e.toString());
      emit(LoadMoreUnsuccessfulState());
    }
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<CharacterPageState> emit,
  ) async {
    if (event.charactersList != null) {
      _characters.addAll(event.charactersList!);
      emit(SuccessfulPageState(event.charactersList!));
    } else {
      emit(InitialUnsuccessfulState());
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetInitialDataEvent event,
    Emitter<CharacterPageState> emit,
  ) async {
    emit(InitialLoadingMainPageState());
    try {
      var data = await _charactersRepository.getCharacters(event.page);
      add(DataLoadedOnMainPageEvent(data));
    } catch (e) {
      print(e.toString());
      emit(InitialUnsuccessfulState());
    }
  }
}
