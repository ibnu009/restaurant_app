import 'package:flutter/cupertino.dart';

class FavoriteModuleProvider extends ChangeNotifier {
  final List<String> _favoritedRestaurants = [];

  List<String> get favoritedRestaurants => _favoritedRestaurants;

  void addToFavorite(String restaurantId) {
    _favoritedRestaurants.add(restaurantId);
    notifyListeners();
  }

  void removeFromFavorite(String restaurantId) {
    _favoritedRestaurants.remove(restaurantId);
    notifyListeners();
  }
}
