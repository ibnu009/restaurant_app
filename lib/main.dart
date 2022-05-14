import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/network_provider.dart';
import 'package:restaurant_app/provider/notification_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/screens/detail_restaurant_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/search_restaurant_result.dart';
import 'package:restaurant_app/source/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/source/local/database_helper.dart';
import 'package:restaurant_app/source/network/services/restaurant_network_service.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkProvider(
            networkService: RestaurantNetworkService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
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
