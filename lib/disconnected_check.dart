import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityListener extends StatefulWidget {
  final Widget child;

  const ConnectivityListener({required this.child, super.key});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  late final Connectivity _connectivity;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.mobile &&
          result != ConnectivityResult.wifi) {
        _showNoInternetSnackBar();
      }
    });
  }

  void _showNoInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No Internet Connection'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
