import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../SplashScreenPage.dart';
import 'NoInternetPage.dart';

class ConnectionWrapper extends StatefulWidget {
  const ConnectionWrapper({super.key});

  @override
  State<ConnectionWrapper> createState() => _ConnectionWrapperState();
}

class _ConnectionWrapperState extends State<ConnectionWrapper> {
  bool _isChecking = true;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    setState(() {
      _isChecking = true;
    });

    // First check if device has any network interface (wifi/mobile)
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // no network at all
      setState(() {
        _hasInternet = false;
        _isChecking = false;
      });
      return;
    }

    // Then confirm actual internet by pinging Google
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _hasInternet = true;
          _isChecking = false;
        });
        return;
      }
    } catch (e) {
      // lookup failed
    }

    // If we reach here, network exists but no internet
    setState(() {
      _hasInternet = false;
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasInternet) {
      return NoInternetPage(onRetry: _checkInternet);
    }

    return const SplashScreenPage();
  }
}
