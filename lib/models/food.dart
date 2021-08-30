import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  late String name;
  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> data) => _$FoodFromJson(data);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
