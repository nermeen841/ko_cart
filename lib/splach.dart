// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/country.dart';
import 'package:kocart/models/fav.dart';
import 'package:kocart/screens/auth/country.dart';
import 'package:kocart/screens/lang.dart';
import 'models/home_item.dart';
import 'models/user.dart';
import 'screens/home_folder/home_page.dart';

class Splach extends StatefulWidget {
  const Splach({Key? key}) : super(key: key);

  @override
  _SplachState createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  Future go() async {
    await Future.delayed(const Duration(milliseconds: 50), () async {
      String? lang = prefs.getString('language_code');
      if (lang != null) {
        if (login) {
          getLikes();
          getCountries();
          await getHomeItems();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        } else {
          await getCountries();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Country(1)),
              (route) => false);
        }
      } else {
        getCountries();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LangPage()),
            (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      String? token = prefs.getString('token');
      if (token == null) {
        String? _token = await FirebaseMessaging.instance.getToken();
        if (_token != null) {
          prefs.setString('token', _token);
          setToken(_token);
        }
      } else {
        setToken(token);
      }
      int id = prefs.getInt('id') ?? 0;
      setUserId(id);
      bool login = prefs.getBool('login') ?? false;
      print("loooooooooooooooooogin: " + login.toString());
      setLogin(login);
      userName = prefs.getString('userName');
      String auth = prefs.getString('auth') ?? '';
      setAuth(auth);
      go();
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    setSize(w, h);
    print([1, Navigator.canPop(context)]);
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splach.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
