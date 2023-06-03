import 'package:filmfinder_app/utils/coloors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFlutterToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Coolors.kGenereColors[2],
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }

  static void showErrorToast(String errorMsg){
      Fluttertoast.showToast(
        msg: errorMsg,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    }

    
  }

// Here we will define all the static utilities including the helper functions
// and UI elements