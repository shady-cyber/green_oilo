import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reni/screens/data/model/order_model.dart';
import 'business/shared/widgets/no_internet_error_pop_up.dart';

class NetworkConnectivity {
  final logger = Logger();
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;


  NetworkConnectivity(){}

  Future<bool> initialise(BuildContext context) async {
    // Check the connectivity status and handle it properly
    List<ConnectivityResult> results = await _networkConnectivity.checkConnectivity();
    // Loop through the results to determine the current connectivity status
    for (var result in results) {
      _checkStatus(result, context);
    }
    // Listen for connectivity changes
    _networkConnectivity.onConnectivityChanged.listen((result) {
      for (var result in results) {
        _checkStatus(result, context);
      }
    });
    // Return true if at least one valid connectivity result indicates a connection
    return results.any((result) => result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
  }

// 2.
  Future<bool> _checkStatus(
      ConnectivityResult result, BuildContext context) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
      log('no connection');

      showDialog(
          context: context,
          builder: (context) {
            return const NoInternetErrorPopUp();
          });
    }
    _controller.sink.add({result: isOnline});
    return isOnline;
  }

  void disposeStream() => _controller.close();
}
