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
  // 1.
  Future<bool> initialise(BuildContext context) async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result, context);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result, context);
    });
    return _checkStatus(result, context);
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
