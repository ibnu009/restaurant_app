import 'dart:convert';

import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';

RestaurantSearchResponse restaurantResponseFromJson(String str) =>
    RestaurantSearchResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantSearchResponse data) =>
    json.encode(data.toJson());

class RestaurantSearchResponse {
  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantForList> restaurants;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantForList>.from(
            json["restaurants"].map((x) => RestaurantForList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
