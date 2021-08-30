import 'dart:convert';
import 'package:restaurant_app/models/restaurant.dart';

// part 'restaurants.g.dart';

class Restaurants {
  late List<Restaurant> restaurants;
  Restaurants({required this.restaurants});
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
