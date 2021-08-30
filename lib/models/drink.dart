import 'package:json_annotation/json_annotation.dart';

part 'drink.g.dart';

@JsonSerializable()
class Drink {
  late String name;
  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> data) => _$DrinkFromJson(data);

  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}
