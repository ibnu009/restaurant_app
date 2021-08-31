import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        DetailRestaurantScreen.routeName: (context) => DetailRestaurantScreen(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
