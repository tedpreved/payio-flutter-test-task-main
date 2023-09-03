import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';


@JsonSerializable()
class PageInfo {
  int count;
  int pages;
  String? next;
  String? prev;

  PageInfo(
      {required this.count,
        required this.pages,
        required this.next,
        required this.prev});
  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}