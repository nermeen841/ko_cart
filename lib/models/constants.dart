// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocart/screens/home_folder/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/screens/auth/login.dart';

SystemUiOverlayStyle st = SystemUiOverlayStyle(
  statusBarColor: mainColor,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.light,
);
String domain = 'https://kocart.net/api/V1/';
String imagePath = 'https://kocart.net/assets/images/products/min/';
String imagePath2 = 'https://kocart.net/assets/images/products/gallery/';
String imagePathCat = 'https://kocart.net/assets/images/categories/';
String language = 'en';
String getCurrancy() {
  return prefs.getStringList("currency").toString();
}

int studentId = 0;
void setLang(lang) {
  language = lang;
}

late String token;
void setToken(String _token) {
  token = _token;
}

void changeLang() {
  if (language == 'en') {
    language = 'en';
  } else {
    language = 'id';
  }
}

double h = 0.0;
double w = 0.0;
void setSize(_w, _h) {
  h = _h;
  w = _w;
}

late SharedPreferences prefs;
Future startShared() async {
  prefs = await SharedPreferences.getInstance();
}

////////////////////////////////////////////////////////////////////////////////////////
Future<void> showCatchDialog({
  required BuildContext context,
  required String image,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.topStart,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.clear,
                    color: mainColor,
                  ),
                ),
              ),
              Container(
                width: w,
                height: h * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

///////////////////////////////////////////////////////////////////////////////////////////////
void navP(context, className) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className));
}

void navPR(context, className) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => className));
}

// void navPRRU(context,className){
//   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>className), (route) => route.isActive);
// }
void navPop(context) {
  Navigator.pop(context);
}

void navPopU(context) {
  Navigator.popUntil(context, (route) => false);
}

void showBar(context, msg) {
  var bar = SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: translate(context, 'snack_bar', 'undo'),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}

void dialog(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        child: Opacity(
          opacity: 0.7,
          child: Container(
            width: w,
            height: h,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            ),
          ),
        ),
        onWillPop: () async => false,
      );
    },
  );
}

void alertSuccess(context) {
  AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          showCloseIcon: true,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'success'),
          desc: translate(context, 'alert', 'operation'),
          btnOkOnPress: () {},
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: (type) {
            // navPop(context);
          })
      .show();
}

void alertSuccessCart(context) {
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc: translate(context, 'alert', 'operation'),
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }).show();
}

void alertSuccessAddress(context) {
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc: translate(context, 'alert', 'operation'),
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        int count = 3;
        Navigator.popUntil(context, (route) => count-- <= 0);
      }).show();
}

void alertSuccessData(context, data) {
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc: data,
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        navPop(context);
      }).show();
}

void alertSuccessNoBack(context) {
  AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          showCloseIcon: true,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'success'),
          desc: translate(context, 'alert', 'operation'),
          btnOkOnPress: () {},
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: (type) {})
      .show();
}

void alertSuccessPass(context) {
  AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: translate(context, 'alert', 'success'),
      desc: translate(context, 'alert', 'operation'),
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      }).show();
}

// String countryCode = '+62';
// List<int> countryNumber = [6,7,8,9] ;
void error(context) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'failed'),
          desc: translate(context, 'alert', 'try'),
          btnOkOnPress: () {},
          onDissmissCallback: (val) {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
      .show();
}

void errorWPop(context) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'failed'),
          desc: translate(context, 'alert', 'try'),
          btnOkOnPress: () {},
          onDissmissCallback: (val) {
            navPop(context);
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
      .show();
}

void customError(context, data) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'failed'),
          desc: data,
          btnOkOnPress: () {},
          onDissmissCallback: (val) {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
      .show();
}

void customErrorWPop(context, data) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          dismissOnTouchOutside: false,
          title: translate(context, 'alert', 'failed'),
          desc: data,
          btnOkOnPress: () {},
          onDissmissCallback: (val) {
            navPop(context);
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
      .show();
}

TextDirection getDirection({bool normal = true}) {
  print(normal);
  if (normal) {
    return language == 'en' ? TextDirection.ltr : TextDirection.rtl;
  } else {
    return language == 'en' ? TextDirection.rtl : TextDirection.ltr;
  }
}

bool isLeft() {
  return language == 'en' ? true : false;
}

// String parseHtmlString(String htmlString) {
//   final document = parse(htmlString);
//   final String parsedString = parse(document.body!.text).documentElement!.text;
//   return parsedString;
// }
