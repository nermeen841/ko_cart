// ignore_for_file: avoid_print

import 'package:kocart/models/cart.dart';
import 'package:kocart/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/screens/cart/confirm_cart.dart';
import 'package:provider/provider.dart';

import 'orders.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final num couponPrice;
  final String? couponName;
  final bool couponPercentage;
  const PaymentScreen(
      {Key? key,
      required this.url,
      required this.couponPrice,
      required this.couponName,
      required this.couponPercentage})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      List data = [];
      data = url.split("/");
      if (data[6].toString().substring(33, 52).toString() ==
          "Result=NOT%20CAPTUR") {
        flutterWebviewPlugin.close();
        error(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmCart(
                    couponPrice: widget.couponPrice,
                    couponName: widget.couponName,
                    couponPercentage: widget.couponPercentage)));

        print("111111111111111111111111111111111111111111111111111111");
      } else if (data[6].toString().substring(33, 52).toString() ==
          "Result=CAPTURED&Pos") {
        flutterWebviewPlugin.close();
        getOrders().then((value) {
          Provider.of<CartProvider>(context, listen: false).clearAll();
          if (value) {
            dbHelper.deleteAll();
            navPR(context, Orders());

            return null;
          } else {
            flutterWebviewPlugin.close();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmCart(
                        couponPrice: widget.couponPrice,
                        couponName: widget.couponName,
                        couponPercentage: widget.couponPercentage)));
            print('asdss1');
            error(context);
            return null;
          }
        });
      } else if (data[6].toString().substring(33, 52).toString() ==
          "Result=CANCELED&Pos") {
        flutterWebviewPlugin.close();
        error(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmCart(
                    couponPrice: widget.couponPrice,
                    couponName: widget.couponName,
                    couponPercentage: widget.couponPercentage)));
        print("111111111111111111111111111111111111111111111111111111");
      }
      print(data[5].toString());
      print(data[6].toString().substring(33, 52).toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WebviewScaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            translate(context, 'check_out', 'title'),
            style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          leading: BackButton(
            color: mainColor,
            onPressed: () {
              flutterWebviewPlugin.close();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmCart(
                        couponPrice: widget.couponPrice,
                        couponName: widget.couponName,
                        couponPercentage: widget.couponPercentage)),
              );
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        url: widget.url,
        withJavascript: true,
        mediaPlaybackRequiresUserGesture: true,
        debuggingEnabled: false,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
