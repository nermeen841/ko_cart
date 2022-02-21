// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:kocart/elements/small_widget.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/cart.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/home_item.dart';
import 'package:kocart/models/user.dart';
import 'package:kocart/provider/AuthenticationProvider.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/provider/home.dart';
import 'package:kocart/screens/auth/sign_up.dart';
import 'package:kocart/screens/home_folder/home_page.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'confirm_phone.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool select = true;
  TextEditingController editingController1 = TextEditingController();
  TextEditingController editingController2 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    print([3, Navigator.canPop(context)]);
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SizedBox(
            width: w,
            height: h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.02,
                  ),
                  SizedBox(
                    width: w * 0.55,
                    height: h * 0.4,
                    child: Image.asset(
                      'assets/logo2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                      color: mainColor2,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.02),
                      child: Container(
                        width: w,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.05,
                              ),
                              Text(
                                translate(context, 'login', 'login'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              TextFormField(
                                controller: editingController1,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                focusNode: focusNode1,
                                onEditingComplete: () {
                                  focusNode1.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(focusNode2);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return translate(
                                        context, 'validation', 'field');
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: SmallWidget.form(),
                                  enabledBorder: SmallWidget.form(),
                                  errorBorder: SmallWidget.form(),
                                  focusedErrorBorder: SmallWidget.form(),
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText:
                                      translate(context, 'inputs', 'phone'),
                                  hintText:
                                      translate(context, 'inputs', 'phone'),
                                  hintStyle:
                                      const TextStyle(color: Colors.black45),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.04,
                              ),
                              TextFormField(
                                controller: editingController2,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                                obscureText: true,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                focusNode: focusNode2,
                                onEditingComplete: () {
                                  focusNode2.unfocus();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return translate(
                                        context, 'validation', 'field');
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: SmallWidget.form(),
                                  enabledBorder: SmallWidget.form(),
                                  errorBorder: SmallWidget.form(),
                                  focusedErrorBorder: SmallWidget.form(),
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText:
                                      translate(context, 'inputs', 'pass'),
                                  hintText:
                                      translate(context, 'inputs', 'pass'),
                                  hintStyle:
                                      const TextStyle(color: Colors.black45),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.05,
                              ),
                              RoundedLoadingButton(
                                controller: _btnController,
                                child: SizedBox(
                                  width: w * 0.9,
                                  height: h * 0.07,
                                  child: Center(
                                      child: Text(
                                    translate(context, 'buttons', 'login'),
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: w * 0.07,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                successColor: mainColor,
                                color: Colors.white,
                                borderRadius: 10,
                                height: h * 0.09,
                                disabledColor: Colors.white,
                                errorColor: Colors.white,
                                valueColor: mainColor,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    AuthenticationProvider.userLogin(
                                            email: editingController1.text,
                                            password: editingController2.text
                                                .toString(),
                                            context: context)
                                        .then((value) async {
                                      if (value == true) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false);
                                      } else {
                                        _btnController.error();
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        _btnController.stop();
                                      }
                                    }).catchError((error) {
                                      print("login error ----------" +
                                          error.toString());
                                    });
                                  } else {
                                    _btnController.error();
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    _btnController.stop();
                                  }
                                },
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Text(
                                      translate(context, 'login', 'guest'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () async {
                                      dialog(context);
                                      dbHelper.deleteAll();
                                      Provider.of<BottomProvider>(context,
                                              listen: false)
                                          .setIndex(0);
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .clearAll();
                                      addressGuest = null;
                                      await getHomeItems();
                                      cartId = null;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                          (route) => false);
                                      // navPRRU(context,Home());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: select,
                                          activeColor: Colors.white,
                                          focusColor: Colors.white,
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          checkColor: mainColor,
                                          fillColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          onChanged: (val) {
                                            print(val);
                                            setState(() {
                                              select = !select;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        Text(
                                          translate(
                                              context, 'login', 'remember'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: w * 0.035,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    child: Text(
                                      translate(context, 'login', 'reset'),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () async {
                                      navP(context, const ConfirmPhone());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    translate(context, 'login', 'have_not'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: w * 0.035,
                                    ),
                                  ),
                                  InkWell(
                                    child: Text(
                                      translate(context, 'login', 'register'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      navP(context, SignUp());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
