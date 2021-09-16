import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: _buildScreenBody(context),
    );
  }
}

Widget _buildScreenBody(BuildContext context) {
  return Consumer<PreferencesProvider>(
    builder: (context, preferencesProvider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: Text("Atur Notifikasi"),
              trailing: Consumer<NotificationProvider>(
                builder: (context, notificationProvider, _) {
                  return Switch(
                      value: preferencesProvider.isDailyNewsActive,
                      onChanged: (value) async {
                        preferencesProvider.enableDailyNews(value);
                        notificationProvider.scheduleRestaurant(value);
                      });
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
