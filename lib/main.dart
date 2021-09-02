import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_module_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/search_restaurant_result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteModuleProvider(),
      child: MaterialApp(
        title: 'Restaurant Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScreen(),
          DetailRestaurantScreen.routeName: (context) => DetailRestaurantScreen(
              idRestaurant:
                  ModalRoute.of(context)?.settings.arguments as String),
          SearchRestaurantResult.routeName: (context) => SearchRestaurantResult(
              keyword: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
