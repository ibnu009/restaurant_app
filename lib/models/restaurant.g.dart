// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['pictureId'] as String,
    city: json['city'] as String,
    rating: (json['rating'] as num).toDouble(),
    menu: Menu.fromJson(json['menus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'city': instance.city,
      'rating': instance.rating,
      'menu': instance.menu.toJson(),
    };
