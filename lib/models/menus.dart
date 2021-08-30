import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/models/drink.dart';
import 'package:restaurant_app/models/food.dart';

part 'menus.g.dart';

@JsonSerializable(explicitToJson: true)
class Menu {
  late List<Food> foods;
  late List<Drink> drinks;
  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> data) => _$MenuFromJson(data);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
