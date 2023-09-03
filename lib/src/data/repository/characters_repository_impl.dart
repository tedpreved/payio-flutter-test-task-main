import 'dart:convert';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/response/character_response.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  String nextPageUrl = "";
  List<Character> characters = List.empty(growable: true);

  @override
  Future<List<Character>> getCharacters(int page) async {
    final charResult = await client.get(
      Uri.parse("https://www.rickandmortyapi.com/api/character/?page=$page"),
    );
    final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

    if (charResult.statusCode == 200) {
      if (charResult.body.isNotEmpty) {
        final response = CharacterResponse.fromJson(jsonMap);
        nextPageUrl = response.info.next ?? "";
        characters.addAll(response.results);
        return characters;
      }
    }

    return Future.error("Error while loading data");
  }

  @override
  Future<List<Character>?> loadNextPage() async {
    if (nextPageUrl.isNotEmpty) {
      print(nextPageUrl);
      final charResult = await client.get(Uri.parse(nextPageUrl));

      if (charResult.statusCode == 200) {
        if (charResult.body.isNotEmpty) {
          final Map<String, dynamic> jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

          final response = CharacterResponse.fromJson(jsonMap);

          nextPageUrl = response.info.next ?? "";
          characters.addAll(response.results);

          return Future.value(characters);
        }
      }
    }
    return Future.value(null);
  }
}
