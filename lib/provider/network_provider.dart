import 'package:flutter/material.dart';
import 'package:restaurant_app/source/data/models/restaurant.dart';
import 'package:restaurant_app/source/network/services/restaurant_network_service.dart';

import '../utils/result_state.dart';

class NetworkProvider extends ChangeNotifier {
  final RestaurantNetworkService networkService;
  NetworkProvider({required this.networkService});

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Restaurant? _restaurants;
  Restaurant? get restaurant => _restaurants;

  void getDetailRestaurant(String id) async {
    _state = ResultState.Loading;
    print("loading");
    try {
      var response = await networkService.fetchRestaurantDetail(id);
      print("masuk ke response");
      _state = ResultState.HasData;
      _restaurants = response.restaurant;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error karena $e';
    }
    notifyListeners();
  }
}
