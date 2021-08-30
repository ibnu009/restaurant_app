import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/models/menus.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {
  late String id;
  late String name;
  late String description;
  late String image;
  late String city;
  late double rating;
  late Menu menu;
  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.city,
      required this.rating,
      required this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> data) =>
      _$RestaurantFromJson(data);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
