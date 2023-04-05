import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kelimeezberle/practical_method.dart';


void showToast(String message){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(PracticalMethod.HexaColorConvertColor("#323ba4")),
      textColor: Colors.white,
      fontSize: 16.0
  );
}