import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class ConnectionSupervisor {
  ConnectionSupervisor._();

  static final _instance = ConnectionSupervisor._();
  static ConnectionSupervisor get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void init() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((event) {
      _checkStatus(event);
    });
  }

  void disposeConnectionStream() => _controller.close();
}
