import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService extends ChangeNotifier {
  bool _hasConnection = false;
  bool get hasConnection => _hasConnection;

  late final StreamSubscription<InternetStatus> _subscription;

  ConnectivityService() {
    _subscription = InternetConnection().onStatusChange.listen((event) {
      final connected = (event == InternetStatus.connected);
      if (_hasConnection != connected) {
        _hasConnection = connected;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
