import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/source/local/database_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavoriteRestaurants();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantForList> _restaurants = [];
  List<RestaurantForList> get restaurants => _restaurants;

  void _getFavoriteRestaurants() async {
    _restaurants = await databaseHelper.getFavoriteRestaurants();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.EmptyData;
      _message = 'Data Kosong';
    }
    notifyListeners();
  }

  void addToFavoriteRestaurant(RestaurantForList restaurant) async {
    try {
      await databaseHelper.insertRestaurantToFavorite(restaurant);
      _getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error karena $e';
      notifyListeners();
    }
  }

  void removeFromFavoriteRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurantFromFavorite(id);
      _getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error karena $e';
    }
  }

  Future<bool> isRestaurantFavorited(String id) async {
    final favoritedRestaurant =
        await databaseHelper.getFavoriteRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }
}
