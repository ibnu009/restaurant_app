import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/search_restaurant_result.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/source/network/responses/restaurant_response.dart';
import 'package:restaurant_app/source/network/services/restaurant_network_service.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Future<RestaurantResponse> _futureRestaurants;

  final TextEditingController _searchController = TextEditingController();
  Widget _appBarTitle = Text('Restaurant App');
  Icon _searchIcon = Icon(Icons.search);
  String _searchHintText = 'Cari restaurant atau makanan apa?';

  @override
  void initState() {
    super.initState();
    _futureRestaurants = RestaurantNetworkService().fetchRestaurants();
  }

  void _onSearchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _searchController,
          onSubmitted: (value) {
            if (value.isEmpty) {
            } else {
              Navigator.pushNamed(context, SearchRestaurantResult.routeName,
                  arguments: value);
            }
          },
          decoration: InputDecoration(
            hintText: _searchHintText,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        );
      } else {
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text('Restaurant App');
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        leading: IconButton(onPressed: _onSearchPressed, icon: _searchIcon),
      ),
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FutureBuilder(
          future: _futureRestaurants,
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            switch (state) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return _homeScreenBody(snapshot, screen);
              default:
                return Text('');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

Widget _homeScreenBody(AsyncSnapshot<Object?> snapshot, Size screen) {
  if (snapshot.hasError) {
    return Center(child: Text("Terjadi Kesalahan"));
  } else if (snapshot.hasData) {
    var data = snapshot.data as RestaurantResponse;

    if (data.restaurants.isEmpty) {
      return Center(
        child: Text("Empty"),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 280,
        ),
        itemCount: data.restaurants.length,
        itemBuilder: (_, index) {
          RestaurantForList restaurant = data.restaurants[index];
          return Consumer<DatabaseProvider>(
            builder: (context, provider, widget) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailRestaurantScreen.routeName,
                      arguments: data.restaurants[index].id);
                },
                child: Hero(
                  tag: restaurant.id,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: restaurantItem(
                      restaurant: restaurant,
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }
  } else {
    return Text('');
  }
}
