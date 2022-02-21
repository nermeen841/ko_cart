import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/country.dart';
import 'package:kocart/screens/auth/reset_pass.dart';

class ConfirmPhone extends StatefulWidget {
  const ConfirmPhone({Key? key}) : super(key: key);

  @override
  _ConfirmPhoneState createState() => _ConfirmPhoneState();
}

class _ConfirmPhoneState extends State<ConfirmPhone> {
  final _formKey = GlobalKey<FormState>();
  late int id;
  String? verificationId;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final TextEditingController _controller = TextEditingController();
  Future verifyPhone() async {
    String url = domain;
    try {
      url = url + 'check-phone';
      Response response = await Dio().post(url, data: {
        'phone': _controller.text,
      });
      if (response.data['status'] == 0) {
        final snackBar = SnackBar(
          content: Text(translate(context, 'snack_bar', 'phone')),
          action: SnackBarAction(
            label: translate(context, 'snack_bar', 'undo'),
            disabledTextColor: Colors.yellow,
            textColor: Colors.yellow,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _btnController.stop();
      }
      if (response.data['status'] == 1) {
        Map userData = response.data['data'];
        id = userData['id'];
        fireSms(context, _controller.text, _btnController);
      }
    } catch (e) {
      _btnController.error();
      await Future.delayed(const Duration(milliseconds: 700));
      _btnController.stop();
    }
  }

  Future fireSms(context, String phone,
      RoundedLoadingButtonController _btnController) async {
    final TextEditingController sms = TextEditingController();
    try {
      String ph = countryCode + phone;
      Future<PhoneVerificationFailed?> verificationFailed(
          FirebaseAuthException authException) async {
        _btnController.error();
        await Future.delayed(const Duration(milliseconds: 1000));
        _btnController.stop();
        showBar(context, translate(context, 'fire_base', 'error1'));
      }

      Future<PhoneCodeAutoRetrievalTimeout?> autoTimeout(String varId) async {
        verificationId = varId;
        _btnController.stop();
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: ph,
          timeout: const Duration(seconds: 90),
          verificationCompleted: (AuthCredential credential) async {
            try {
              var result =
                  await FirebaseAuth.instance.signInWithCredential(credential);
              var ha = result.user;
              if (ha != null) {
                _btnController.stop();
                navPR(context, ResetPass(id: id));
              }
            } catch (e) {
              _btnController.error();
              await Future.delayed(const Duration(milliseconds: 1000));
              _btnController.stop();
              showBar(context, translate(context, 'fire_base', 'error2'));
            }
          },
          verificationFailed: verificationFailed,
          codeSent: (String verificationId, [int? forceResendingToken]) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                      ),
                    ),
                    titlePadding: const EdgeInsets.only(left: 0, bottom: 0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    content: SizedBox(
                      height: h * 30 / 100,
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: Text(
                              translate(context, 'sms', 'title'),
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 5 / 100),
                            ),
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: h * 2 / 100,
                          ),
                          Directionality(
                            textDirection: getDirection(),
                            child: TextField(
                              controller: sms,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: translate(context, 'sms', 'hint'),
                                contentPadding: EdgeInsets.zero,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: mainColor,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: h * 1.5 / 100,
                          ),
                          InkWell(
                            child: Container(
                              width: w * 30 / 100,
                              height: h * 6 / 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Text(
                                  translate(context, 'buttons', 'send'),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: w * 4.5 / 100,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (sms.text != '') {
                                try {
                                  FocusScope.of(context).unfocus();
                                  AuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: sms.text);
                                  var result = await FirebaseAuth.instance
                                      .signInWithCredential(credential);
                                  var ha = result.user;
                                  if (ha != null) {
                                    sms.text = '';
                                    _btnController.stop();
                                    Navigator.pop(dialogContext);
                                    navPR(context, ResetPass(id: id));
                                  }
                                } catch (e) {
                                  customError(
                                      context,
                                      translate(
                                          context, 'fire_base', 'error2'));
                                  // Navigator.pop(dialogContext);
                                  _btnController.error();
                                  await Future.delayed(
                                      const Duration(milliseconds: 1000));
                                  _btnController.stop();
                                  // showBar(context, 'رمز التحقق غير صحيح', 'Verification code is wrong','العربية');
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                        top: 0,
                        right: w * 2 / 100,
                        left: w * 2 / 100,
                        bottom: 0),
                  );
                }).then((value) {
              _btnController.reset();
            });
          },
          codeAutoRetrievalTimeout: autoTimeout);
    } catch (e) {
      // showBar(context, e, e);
      _btnController.error();
      await Future.delayed(const Duration(milliseconds: 1000));
      _btnController.stop();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                content: SizedBox(
                    height: h * 0.5,
                    width: h / 3.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [Text(e.toString())],
                      ),
                    )),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Directionality(
            textDirection: getDirection(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  translate(context, 'reset_pass', 'title'),
                  style: TextStyle(
                      fontSize: w * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: BackButton(
                  color: mainColor,
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h * 0.04,
                      ),
                      Text(
                        translate(context, 'reset_pass', 'sub_title1'),
                        style: TextStyle(
                            fontSize: w * 0.035, color: Colors.grey[600]),
                      ),
                      Text(
                        translate(context, 'reset_pass', 'sub_title2'),
                        style: TextStyle(
                            fontSize: w * 0.035, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      TextFormField(
                        controller: _controller,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return translate(context, 'validation', 'field');
                          }
                          if (value.length != countryNumber) {
                            return translate(context, 'validation', 'phone');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: form(),
                            enabledBorder: form(),
                            errorBorder: form(),
                            focusedErrorBorder: form(),
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: translate(context, 'inputs', 'phone'),
                            hintStyle: const TextStyle(color: Colors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            errorMaxLines: 1,
                            errorStyle: TextStyle(fontSize: w * 0.03)),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: h * 0.06,
                      ),
                      RoundedLoadingButton(
                        child: Container(
                          height: h * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: mainColor,
                          ),
                          child: Center(
                            child: Text(
                              translate(context, 'buttons', 'send'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        controller: _btnController,
                        successColor: mainColor,
                        color: mainColor,
                        disabledColor: mainColor,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            // fireSms(context, _controller.text, _btnController);
                            verifyPhone();
                          } else {
                            _btnController.error();
                            await Future.delayed(
                                const Duration(milliseconds: 1000));
                            _btnController.stop();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  InputBorder form() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: (Colors.white), width: 1),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
