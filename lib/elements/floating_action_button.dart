import 'package:flutter/material.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/provider/student_provider.dart';
import 'package:kocart/screens/student/student.dart';

Widget floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () async {
      dialog(context);
      await getStudentsHome();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Student()));
    },
    backgroundColor: mainColor,
    child: Center(
      child: Image.asset("assets/brand.png", fit: BoxFit.contain),
    ),
  );
}
