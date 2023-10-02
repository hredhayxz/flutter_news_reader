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
  var hasError = false;

  Future<void> checkInternet() async {
    try {
      result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        isConnected = true;
        setState(() {});
      } else {
        isConnected = false;
      }
    } catch (error) {
      print('Error in checkInternet: $error');
      isConnected = false;
    }
    hasError = isConnected == false;
    setState(() {});
  }

  void startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      checkInternet();
    }, onError: (error) {
      print('Error in startStreaming: $error');
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
        body: hasError ? OfflineNewsListScreen() : OnlineNewsListScreen());
  }
}
