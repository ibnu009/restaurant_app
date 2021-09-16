import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class FavoriteRestaurantScreen extends StatefulWidget {
  @override
  _FavoriteRestaurantScreenState createState() =>
      _FavoriteRestaurantScreenState();
}

class _FavoriteRestaurantScreenState extends State<FavoriteRestaurantScreen> {
  Widget _appBarTitle = Text('Favorite Restaurant');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _appBarTitle,
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(250, 250, 250, 250),
        body: _buildList());
  }
}

Widget _buildList() {
  return Consumer<DatabaseProvider>(builder: (context, provider, child) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 230,
            childAspectRatio: 3.5 / 4,
            mainAxisSpacing: 12,
          ),
          itemCount: provider.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = provider.restaurants[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailRestaurantScreen.routeName,
                    arguments: restaurant.id);
              },
              child: Hero(
                tag: restaurant.id,
                child: restaurantItem(
                  restaurant: restaurant,
                ),
              ),
            );
          },
        ));
  });
}
