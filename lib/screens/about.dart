// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/info.dart';

class AboutUs extends StatelessWidget {
  final title;
  AboutUs(this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: getDirection(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            title,
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
        body: info.isEmpty
            ? Center(
                child: Text(
                  translate(context, 'empty', 'empty'),
                  style: TextStyle(color: mainColor, fontSize: w * 0.05),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: w * .05, left: w * 0.05, top: h * 0.01),
                  child: SizedBox(
                    width: w * 0.9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var e in info)
                          Column(
                            children: [
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     CircleAvatar(
                              //       backgroundColor: mainColor,
                              //       radius: w * 0.02,
                              //     ),
                              //     SizedBox(
                              //       width: w * .05,
                              //     ),
                              //     SizedBox(
                              //       width: w * 0.75,
                              //       child: Text(
                              //         e.name,
                              //         style: TextStyle(
                              //             color: mainColor,
                              //             fontSize: w * 0.05,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(
                                height: h * 0.01,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: mainColor,
                                    radius: w * 0.02,
                                  ),
                                  SizedBox(
                                    width: w * .05,
                                  ),
                                  SizedBox(
                                    width: w * 0.75,
                                    child: Text(
                                      (prefs.getString('language_code') == 'en')
                                          ? e.desEn
                                          : e.desAr,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                            ],
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
