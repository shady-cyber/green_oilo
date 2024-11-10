import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reni/screens/data/model/order_model.dart';
import 'business/shared/widgets/no_internet_error_pop_up.dart';

class logs {
  final logger = Logger();

  logs() {}
  // 1.
  void logData(Order order) {
    if (kReleaseMode || kProfileMode) {
      debugPrint('Order details: ${order.customer.fullName}, ${order.address
          .addressLine1}, ${order.address.addressLine2}, ${order.customer
          .mobileNumber}, ${order.quantity}, ${order.gift.giftName}');
    } else {
      debugPrint('Order details: ${order.customer.fullName}, ${order.address
          .addressLine1}, ${order.address.addressLine2}, ${order.customer
          .mobileNumber}, ${order.quantity}, ${order.gift.giftName}');
    }
  }

  void logDataString(String order) {
    if (kReleaseMode || kProfileMode) {
      debugPrint('Mobile number: ${order}');
    } else {
      debugPrint('Mobile number: ${order}');
    }
  }

  void logDataBool(bool order) {
    if (kReleaseMode || kProfileMode) {
      debugPrint('Mobile number: ${order}');
    } else {
      debugPrint('Mobile number: ${order}');
    }
  }
}