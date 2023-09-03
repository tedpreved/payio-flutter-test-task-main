import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String name;
  final String image;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;

  Character(this.name, this.image, this.status, this.species, this.type, this.gender);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
