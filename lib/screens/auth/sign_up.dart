// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, prefer_final_fields, use_key_in_widget_constructors, unused_element

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kocart/elements/small_widget.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/provider/AboutProvider.dart';
import 'package:kocart/provider/AuthenticationProvider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../about.dart';

final _formKey = GlobalKey<FormState>();
final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();
final List<String> _hint = language == 'en'
    ? ['Name', 'E-mail', 'phone number', 'password', 'confirm password']
    : [
        'الاسم بالكامل',
        'البريد الاكتروني',
        'رقم الهاتف',
        'كلمة المرور',
        'تاكيد كلمة المرور'
      ];
late Timer timer;
int counter = 60;
bool dialogSms = false, makeError = false, finishSms = true, checkRe = false;
// ignore: unused_field
bool _visibility1 = true, _visibility2 = true, check = true;
List<FocusNode> _listFocus = List<FocusNode>.generate(5, (_) => FocusNode());
List<TextEditingController> _listEd =
    List<TextEditingController>.generate(5, (_) => TextEditingController());
String? verificationId;

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: mainColor,
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
                      'assets/signup.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                    width: w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                            translate(context, 'login', 'register'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: w * 0.06,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          for (int i = 0; i < _listEd.length; i++)
                            Padding(
                              padding: EdgeInsets.only(bottom: h * 0.04),
                              child: TextFormField(
                                controller: _listEd[i],
                                style: const TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                                cursorColor: Colors.black,
                                obscureText: i == 3 || i == 4 ? true : false,
                                textInputAction: i < 2
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                focusNode: _listFocus[i],
                                onEditingComplete: () {
                                  _listFocus[i].unfocus();
                                  if (i < 2) {
                                    FocusScope.of(context)
                                        .requestFocus(_listFocus[i + 1]);
                                  }
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
                                      const TextStyle(color: Colors.red),
                                  labelText: _hint[i],
                                  hintText: _hint[i],
                                  hintStyle:
                                      const TextStyle(color: Colors.black45),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          RoundedLoadingButton(
                            controller: _btnController,
                            child: SizedBox(
                              width: w * 0.9,
                              height: h * 0.07,
                              child: Center(
                                  child: Text(
                                translate(context, 'buttons', 'register'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.07,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            successColor: Colors.white,
                            color: mainColor,
                            borderRadius: 10,
                            height: h * 0.09,
                            disabledColor: mainColor,
                            errorColor: Colors.red,
                            valueColor: Colors.white,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (FirebaseAuth.instance.currentUser != null)
                                FirebaseAuth.instance.signOut();
                              if (finishSms) {
                                if (_formKey.currentState!.validate()) {
                                  await AuthenticationProvider.register(
                                      context: context,
                                      name: _listEd[0],
                                      phone: _listEd[2],
                                      password: _listEd[3],
                                      confirmPassword: _listEd[4],
                                      email: _listEd[1],
                                      controller: _btnController);
                                } else {
                                  _btnController.error();
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  _btnController.stop();
                                }
                              } else {
                                final snackBar = SnackBar(
                                  content:
                                      Text(translate(context, 'sms', 'wait')),
                                  action: SnackBarAction(
                                    label:
                                        translate(context, 'snack_bar', 'undo'),
                                    disabledTextColor: Colors.yellow,
                                    textColor: Colors.yellow,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                _btnController.stop();
                              }
                            },
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  translate(context, 'login', 'have'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () async {
                                  navPop(context);
                                },
                              ),
                              InkWell(
                                child: Text(
                                  translate(context, 'register', 'terms'),
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () async {
                                  dialog(context);
                                  bool _check = await AboutProvider.getInfo(
                                      'TermsAndConditions');
                                  if (_check) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                AboutUs('Terms & Condition')));
                                  } else {
                                    Navigator.pop(context);
                                    error(context);
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.05,
                          ),
                        ],
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

//////////////////////////////////////////////////////////////////////////////////////////////

