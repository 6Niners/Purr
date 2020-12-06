import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> ShowToast(String text,{Color Background_color}) async {
  if(Background_color==null){
    Background_color=Colors.grey[850];
  }
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Background_color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}