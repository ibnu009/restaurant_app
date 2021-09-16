import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: _buildListFavorite());
  }
}

Widget _buildListFavorite() {
  return Consumer<DatabaseProvider>(
    builder: (context, provider, widget) {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 230,
          childAspectRatio: 3.5 / 4,
          mainAxisSpacing: 12,
        ),
        itemCount: provider.restaurants.length,
        itemBuilder: (context, index) {
          RestaurantForList restaurant = provider.restaurants[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailRestaurantScreen.routeName,
                  arguments: provider.restaurants[index].id);
            },
            child: Consumer<DatabaseProvider>(
              builder: (context, provider, widget) {
                return Hero(
                  tag: restaurant.id,
                  child: restaurantItem(
                    restaurant: restaurant,
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
