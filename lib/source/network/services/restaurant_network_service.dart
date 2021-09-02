import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/source/network/responses/detail_restaurant_response.dart';
import 'package:restaurant_app/source/network/responses/restaurant_response.dart';
import 'package:restaurant_app/source/network/responses/restaurant_search_response.dart';
import 'package:restaurant_app/utils/const_value.dart';

class RestaurantNetworkService {
  //  Fetch All Restaurants
  Future<RestaurantResponse> fetchRestaurants() async {
    final response = await http.get(Uri.parse("$BASE_URL/list"));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data restaurant');
    }
  }

  Future<RestaurantSearchResponse> fetchSearchedRestaurants(
      String keyword) async {
    final response = await http.get(Uri.parse("$BASE_URL/search?q=$keyword"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data restaurant');
    }
  }

  //  Fetch Restaurant's detail
  Future<DetailRestaurantResponse> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$BASE_URL/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data restaurant');
    }
  }
}
