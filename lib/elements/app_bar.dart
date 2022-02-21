// ignore_for_file: non_constant_identifier_names

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:kocart/BottomNavWidget/first_page.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/screens/cart/cart.dart';
import 'package:provider/provider.dart';

class AppBarHome {
  static PreferredSizeWidget app_bar_home(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return AppBar(
      backgroundColor: mainColor,
      automaticallyImplyLeading: false,
      title: Container(
        width: w * 0.1,
        height: w * 0.1,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/logo2.png'),
          fit: BoxFit.cover,
        )),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: w * 0.01),
          child: Padding(
            padding: const EdgeInsets.all(5),
            // child: Icon(Icons.search,color: Colors.white,size: w*0.05,),
            child: Badge(
              badgeColor: mainColor,
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
                focusColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
              ),
              animationDuration: const Duration(
                seconds: 2,
              ),
              badgeContent: Text(
                cart.items.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.03,
                ),
              ),
              position: BadgePosition.topStart(start: w * 0.007),
            ),
          ),
        ),
        SizedBox(
          width: w * 0.02,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(w, h * 0.07),
        child: Container(
          width: w,
          color: Colors.white,
          child: TabBar(
            controller: tabBarHome,
            tabs: [
              Tab(
                text: translate(context, 'home', 'home'),
              ),
              Tab(
                text: translate(context, 'home', 'new'),
              ),
              Tab(
                text: translate(context, 'home', 'best'),
              ),
              Tab(
                text: translate(context, 'home', 'recommendation'),
              ),
              Tab(
                text: translate(context, 'home', 'offers'),
              ),
            ],
            overlayColor: MaterialStateProperty.all(Colors.white),
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 3,
            indicatorColor: mainColor2,
            automaticIndicatorColorAdjustment: true,
            labelColor: mainColor2,
            isScrollable: true,
          ),
        ),
      ),
    );
  }
}
