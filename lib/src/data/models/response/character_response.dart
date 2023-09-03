import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/page_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_response.g.dart';

@JsonSerializable()
class CharacterResponse {
  final PageInfo info;
  final List<Character> results;

  const CharacterResponse({
    required this.info,
    required this.results,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => _$CharacterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);
}
