import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/constants/colors.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}