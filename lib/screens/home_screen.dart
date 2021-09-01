import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FutureBuilder(
          future: getJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              var restaurants = snapshot.data as List<Restaurant>;
              if (restaurants.isEmpty) {
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
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    print(restaurants[index].image);
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, DetailRestaurantScreen.routeName,
                            arguments: restaurants[index]);
                      },
                      child: restaurantItem(context, restaurants[index]),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Restaurant>> getJsonData() async {
    final data =
        await rootBundle.rootBundle.loadString('assets/local_restaurant.json');
    final list = json.decode(data)['restaurants'] as List<dynamic>;
    return list.map((data) => Restaurant.fromJson(data)).toList();
  }
}
