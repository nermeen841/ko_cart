import 'package:flutter/material.dart';

class SmallWidget{
  static InputBorder form() {
    return  OutlineInputBorder(
      borderSide:  BorderSide(color: (Colors.grey[300])!, width: 1),
      borderRadius: BorderRadius.circular(20),
    );
  }
}