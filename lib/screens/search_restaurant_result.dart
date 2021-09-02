import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_module_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/source/network/responses/restaurant_search_response.dart';
import 'package:restaurant_app/source/network/services/restaurant_network_service.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class SearchRestaurantResult extends StatelessWidget {
  static const routeName = '/searchRestaurant';

  final String keyword;
  SearchRestaurantResult({required this.keyword});

  @override
  Widget build(BuildContext context) {
    final Future<RestaurantSearchResponse> _futureSearchedRestaurants =
        RestaurantNetworkService().fetchSearchedRestaurants(keyword);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pencarian'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FutureBuilder(
          future: _futureSearchedRestaurants,
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            switch (state) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return _searchRestaurantBody(snapshot);
              default:
                return Text('');
            }
          },
        ),
      ),
    );
  }

  Widget _searchRestaurantBody(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print(snapshot.error);
      return Center(child: Text("${snapshot.error}"));
    } else if (snapshot.hasData) {
      var data = snapshot.data as RestaurantSearchResponse;

      if (data.restaurants.isEmpty) {
        return Center(
          child: Text("Empty"),
        );
      } else {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            childAspectRatio: 3.5 / 4,
            mainAxisSpacing: 12,
          ),
          itemCount: data.restaurants.length,
          itemBuilder: (context, index) {
            RestaurantForList restaurant = data.restaurants[index];

            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailRestaurantScreen.routeName,
                    arguments: data.restaurants[index].id);
              },
              child: Consumer<FavoriteModuleProvider>(
                builder: (context, FavoriteModuleProvider provider, widget) {
                  bool isFavorite =
                      provider.favoritedRestaurants.contains(restaurant.id);
                  return Hero(
                    tag: restaurant.id,
                    child: restaurantItem(
                        restaurant: restaurant,
                        isFavorited: isFavorite,
                        onFavoriteClick: () {
                          isFavorite
                              ? provider.removeFromFavorite(restaurant.id)
                              : provider.addToFavorite(restaurant.id);
                        }),
                  );
                },
              ),
            );
          },
        );
      }
    } else {
      return Text('');
    }
  }
}
