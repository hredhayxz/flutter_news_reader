import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_reader/presentation/ui/screens/online_news_list_screen.dart';
import 'package:flutter_news_reader/presentation/ui/screens/offline_news_list_screen.dart';

class NetworkConnectivityChecker extends StatefulWidget {
  const NetworkConnectivityChecker({Key? key}) : super(key: key);

  @override
  _NetworkConnectivityCheckerState createState() =>
      _NetworkConnectivityCheckerState();
}

class _NetworkConnectivityCheckerState
    extends State<NetworkConnectivityChecker> {
  late ConnectivityResult result;
  late StreamSubscription<ConnectivityResult> subscription;
  var isConnected = false;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    setState(() {});
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      checkInternet();
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
    startStreaming();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnected == true
            ? const OnlineNewsListScreen()
            : const OfflineNewsListScreen(),
    );
  }
}
