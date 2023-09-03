import 'package:casino_test/src/presentation/bloc/character_bloc.dart';
import 'package:casino_test/src/presentation/bloc/character_event.dart';
import 'package:casino_test/src/presentation/bloc/character_state.dart';
import 'package:casino_test/src/presentation/ui/characters_list_view.dart';
import 'package:casino_test/src/presentation/ui/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final ScrollController _scrollController;
  late final CharactersBloc _charactersBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(keepScrollOffset: true);
    _charactersBloc = context.read<CharactersBloc>();
    _scrollController.addListener(_loadMoreDataScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        actions: [
          BlocBuilder<CharactersBloc, CharacterPageState>(builder: (blocContext, state) {
            if (state is InitialUnsuccessfulState || state is LoadMoreUnsuccessfulState) {
              return IconButton(
                onPressed: () async {
                  if (state is InitialUnsuccessfulState) {
                    _charactersBloc.add(GetInitialDataEvent(1));
                  } else {
                    _charactersBloc.add(const LoadNextPageOnMainPageEvent());
                  }
                },
                icon: const Icon(Icons.refresh),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<CharactersBloc, CharacterPageState>(
            listener: (blocContext, state) {
              if (state is InitialUnsuccessfulState || state is LoadMoreUnsuccessfulState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Something went wrong. Try again later"),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => current is! NextPageLoadingState && current is! LoadMoreUnsuccessfulState,
            builder: (blocContext, state) {
              if (state is InitialLoadingMainPageState) {
                return DefaultLoadingWidget();
              } else if (state is SuccessfulPageState) {
                return CharactersListView(
                  characters: state.charactersList,
                  scrollController: _scrollController,
                );
              } else if (state is InitialUnsuccessfulState) {
                return Center(child: const Text("Something went wrong =(\pTry again later"));
              } else {
                return Center(child: const Text("Something went wrong =(\pTry again later"));
              }
            },
          ),
          BlocBuilder<CharactersBloc, CharacterPageState>(builder: (blocContext, state) {
            if (state is NextPageLoadingState) {
              return LinearProgressIndicator();
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  void _loadMoreDataScrollListener() {
    bool canFetch = _scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
        !_charactersBloc.state.isFetching;

    if (canFetch) {
      _charactersBloc.add(const LoadNextPageOnMainPageEvent());
    }
  }
}
