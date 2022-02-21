// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/order.dart';
import 'package:kocart/provider/home.dart';
import 'package:kocart/screens/home_folder/home_page.dart';
import 'package:provider/provider.dart';
import 'order_info.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    orders = orders.reversed.toList();
    return Directionality(
      textDirection: getDirection(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              translate(context, 'order', 'title'),
              style: TextStyle(
                  fontSize: w * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            leading: BackButton(
              color: mainColor,
              onPressed: () {
                Provider.of<BottomProvider>(context, listen: false).setIndex(4);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: orders.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.1,
                    ),
                    SizedBox(
                      width: w * 0.5,
                      height: h * 0.3,
                      child: SvgPicture.asset(
                        'assets/empty.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.07,
                    ),
                    Text(
                      translate(context, 'empty', 'no_order'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.07,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.07,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: w * 0.05,
                        right: w * 0.05,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              height: h * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  translate(context, 'buttons', 'back'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: h * 0.07,
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, i) {
                    return Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: h * 0.007, bottom: h * 0.005),
                        child: InkWell(
                          child: SizedBox(
                            width: w * 0.9,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: w * 0.9,
                                  height: h * 0.11,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: w * 0.17,
                                        height: h * 0.09,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(orders[i].image),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(
                                        width: w * 0.03,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: h * 0.11,
                                          child: Align(
                                            alignment: isLeft()
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  orders[i].title +
                                                      ' #' +
                                                      orders[i].id.toString(),
                                                  style: TextStyle(
                                                    fontSize: w * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  orders[i].orderStatus,
                                                  style: TextStyle(
                                                    fontSize: w * 0.03,
                                                    color: mainColor,
                                                  ),
                                                ),
                                                Text(
                                                  orders[i].date,
                                                  style: TextStyle(
                                                      fontSize: w * 0.03,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // InkWell(
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.refresh,color: mainColor,size: w*0.05,),
                                      //       SizedBox(width: 5,),
                                      //       Text('اعادة الطلب',style: TextStyle(color: mainColor,fontSize: w*0.04,),),
                                      //     ],
                                      //   ),
                                      //   onTap: (){
                                      //     showDialog(
                                      //       context: context,
                                      //       barrierDismissible: false,
                                      //       builder: (BuildContext context) {
                                      //         return Opacity(
                                      //           opacity: 0.7,
                                      //           child: Container(
                                      //             width: w,
                                      //             height: h,
                                      //             color: Colors.black12,
                                      //             child: Center(
                                      //               child: CircularProgressIndicator(color: mainColor,),
                                      //             ),
                                      //           ),
                                      //         );
                                      //       },
                                      //     );
                                      //     getOrder(orders[i].id, 2, context,orders[i]);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Divider(
                                  height: h * 0.005,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            dialog(context);
                            await getOrder(orders[i].id).then((value) {
                              if (value) {
                                navPR(
                                    context,
                                    OrderInfo(
                                      orderClass: orders[i],
                                    ));
                              } else {
                                navPop(context);
                                error(context);
                              }
                            });
                          },
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
