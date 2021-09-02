import 'dart:convert';

import 'package:restaurant_app/source/data/models/restaurant.dart';

class DetailRestaurantResponse {
  DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

DetailRestaurantResponse welcomeFromJson(String str) =>
    DetailRestaurantResponse.fromJson(json.decode(str));

String welcomeToJson(DetailRestaurantResponse data) =>
    json.encode(data.toJson());
