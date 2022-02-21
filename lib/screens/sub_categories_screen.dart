// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, iterable_contains_unrelated_type, unrelated_type_equality_checks, avoid_print

import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:kocart/dbhelper.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/cart.dart';
import 'package:kocart/models/cat.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/products_cla.dart';
import 'package:kocart/provider/CatProvider.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/screens/cart/cart.dart';
import 'package:provider/provider.dart';

class SubCategoriesScreen extends StatefulWidget {
  List<SubCategories> subcategoriesList;
  SubCategoriesScreen({required this.subcategoriesList});
  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  int selectedSubCat = 0;
  String subCatId = "0";
  var currency = (prefs.getString('language_code').toString() == 'en')
      ? prefs.getString('currencyEn').toString()
      : prefs.getString('currencyAr').toString();

  @override
  void initState() {
    if (widget.subcategoriesList.isNotEmpty) {
      setState(() {
        subCatId = widget.subcategoriesList.first.id.toString();
      });
    }

    super.initState();
  }

  DbHelper helper = DbHelper();
  List<int> att = [];
  List<String> des = [];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CatProvider cat = Provider.of<CatProvider>(context, listen: false);
    CartProvider cart = Provider.of<CartProvider>(context, listen: true);
    return Directionality(
      textDirection: getDirection(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              translate(context, 'multiple', 'title'),
              style: TextStyle(color: Colors.white, fontSize: w * 0.04),
            ),
            centerTitle: false,
            backgroundColor: mainColor,
            leading: const BackButton(
              color: Colors.white,
            ),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
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
            ],
            bottom: PreferredSize(
              preferredSize: Size(w, h * 0.07),
              child: Container(
                height: h * 0.05 + 10,
                padding: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: ListView.separated(
                  itemCount: widget.subcategoriesList.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSubCat = index;
                          subCatId =
                              widget.subcategoriesList[index].id.toString();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: index == selectedSubCat
                                        ? mainColor
                                        : Colors.grey.withOpacity(0.3),
                                    width: 2))),
                        child: Text(
                          prefs.getString('language_code').toString() == 'en'
                              ? widget.subcategoriesList[index].nameEn
                              : widget.subcategoriesList[index].nameAr,
                          style: TextStyle(
                              color: index == selectedSubCat
                                  ? mainColor
                                  : Colors.black45,
                              fontSize: w * 0.05),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: w * 0.03,
                    );
                  },
                ),
              ),
            ),
          ),
          body: Padding(
            padding: isLeft()
                ? EdgeInsets.only(left: w * 0.025, top: h * 0.03)
                : EdgeInsets.only(right: w * 0.025, top: h * 0.03),
            child: SizedBox(
              width: w,
              height: h,
              child: FutureBuilder(
                future: cat.getProducts(subCatId.toString()),
                builder:
                    (context, AsyncSnapshot<List<ProductsModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Text(
                              translate(context, "empty", "empty"),
                              style: TextStyle(color: mainColor),
                            ),
                          )
                        : ListView(
                            primary: true,
                            shrinkWrap: true,
                            children: [
                              Wrap(
                                children:
                                    List.generate(snapshot.data!.length, (i) {
                                  return snapshot.data!.isNotEmpty
                                      ? InkWell(
                                          child: Padding(
                                            padding: isLeft()
                                                ? EdgeInsets.only(
                                                    right: w * 0.025,
                                                    bottom: h * 0.02)
                                                : EdgeInsets.only(
                                                    left: w * 0.025,
                                                    bottom: h * 0.02),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: w * 0.45,
                                                  height: h * 0.28,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data![i].img
                                                              .toString()),
                                                      // image: AssetImage('assets/food${i+1}.png'),
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        w * 0.015),
                                                    child: Align(
                                                      alignment: isLeft()
                                                          ? Alignment.bottomLeft
                                                          : Alignment
                                                              .bottomRight,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          if (cartId == null ||
                                                              cartId ==
                                                                  studentId) {
                                                            try {
                                                              if (!cart.idp
                                                                  .contains(
                                                                      snapshot
                                                                          .data![
                                                                              i]
                                                                          .id)) {
                                                                await helper.createCar(CartProducts(
                                                                    id: null,
                                                                    studentId:
                                                                        studentId,
                                                                    image: snapshot
                                                                        .data![
                                                                            i]
                                                                        .img
                                                                        .toString(),
                                                                    titleAr: snapshot
                                                                        .data![
                                                                            i]
                                                                        .name
                                                                        .toString(),
                                                                    titleEn: snapshot
                                                                        .data![
                                                                            i]
                                                                        .name
                                                                        .toString(),
                                                                    price: double.parse(snapshot
                                                                        .data![i]
                                                                        .regular_price
                                                                        .toString()),
                                                                    quantity: 1,
                                                                    att: att,
                                                                    des: des,
                                                                    idp: int.parse(snapshot.data![i].id.toString()),
                                                                    idc: 0,
                                                                    catNameEn: "",
                                                                    catNameAr: "",
                                                                    catSVG: ""));
                                                              } else {
                                                                int quantity = cart
                                                                    .items
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .idp ==
                                                                        snapshot
                                                                            .data?[i]
                                                                            .id)
                                                                    .quantity;
                                                                await helper.updateProduct(
                                                                    1 +
                                                                        quantity,
                                                                    int.parse(snapshot
                                                                        .data![
                                                                            i]
                                                                        .id
                                                                        .toString()),
                                                                    double.parse(snapshot
                                                                        .data![
                                                                            i]
                                                                        .regular_price
                                                                        .toString()),
                                                                    jsonEncode(
                                                                        att),
                                                                    jsonEncode(
                                                                        des));
                                                              }
                                                              await cart
                                                                  .setItems();
                                                            } catch (e) {
                                                              error(context);
                                                              print('e');
                                                              print(e);
                                                            }
                                                          } else {
                                                            if (cartId ==
                                                                    null ||
                                                                cartId ==
                                                                    studentId) {
                                                              try {
                                                                if (!cart.idp
                                                                    .contains(snapshot
                                                                        .data![
                                                                            i]
                                                                        .id)) {
                                                                  await helper.createCar(CartProducts(
                                                                      id: null,
                                                                      studentId:
                                                                          studentId,
                                                                      image: productCla!
                                                                          .image,
                                                                      titleAr: productCla!
                                                                          .nameAr,
                                                                      titleEn:
                                                                          productCla!
                                                                              .nameEn,
                                                                      price: double.parse(snapshot
                                                                          .data![
                                                                              i]
                                                                          .regular_price
                                                                          .toString()),
                                                                      quantity:
                                                                          1,
                                                                      att: att,
                                                                      des: des,
                                                                      idp: int.parse(
                                                                          snapshot.data![i].id
                                                                              .toString()),
                                                                      idc: int.parse(snapshot
                                                                          .data![i]
                                                                          .id
                                                                          .toString()),
                                                                      catNameEn: "",
                                                                      catNameAr: "",
                                                                      catSVG: ""));
                                                                } else {
                                                                  int quantity = cart
                                                                      .items
                                                                      .firstWhere(
                                                                        (element) =>
                                                                            element.idp ==
                                                                            int.parse(snapshot.data![i].id.toString()),
                                                                      )
                                                                      .quantity;
                                                                  await helper.updateProduct(
                                                                      1 +
                                                                          quantity,
                                                                      int.parse(snapshot
                                                                          .data![
                                                                              i]
                                                                          .id
                                                                          .toString()),
                                                                      double.parse(snapshot
                                                                          .data![
                                                                              i]
                                                                          .regular_price
                                                                          .toString()),
                                                                      jsonEncode(
                                                                          att),
                                                                      jsonEncode(
                                                                          des));
                                                                }
                                                                await cart
                                                                    .setItems();
                                                              } catch (e) {
                                                                print('e');
                                                                print(e);
                                                              }
                                                            } else {}
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              mainColor,
                                                          radius: w * .05,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .shopping_cart_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: w * 0.05,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: w * 0.45,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: h * 0.01,
                                                      ),
                                                      Text(snapshot
                                                          .data![i].name
                                                          .toString()),
                                                      // Text(translateString(snapshot.data![i].name.toString(),
                                                      //     snapshot.data![i].name.toString()),style: TextStyle(fontSize: w*0.035),),
                                                      SizedBox(
                                                        height: h * 0.005,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                if (snapshot
                                                                        .data![
                                                                            i]
                                                                        .in_sale ==
                                                                    true)
                                                                  TextSpan(
                                                                      text:
                                                                          '${snapshot.data![i].sale_price} '
                                                                          '$currency ',
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black)),
                                                                // if (snapshot
                                                                //         .data![i]
                                                                //         .in_sale ==
                                                                //     true)
                                                                //   TextSpan(
                                                                //       text:
                                                                //           '${snapshot.data![i].regular_price} '
                                                                //           '$currency ',
                                                                //       style: const TextStyle(
                                                                //           fontWeight:
                                                                //               FontWeight
                                                                //                   .bold,
                                                                //           color: Colors
                                                                //               .black)),
                                                              ],
                                                            ),
                                                          ),
                                                          if (snapshot.data![i]
                                                                      .in_sale ==
                                                                  true &&
                                                              snapshot.data![i]
                                                                      .disPer !=
                                                                  null)
                                                            Text(
                                                                snapshot
                                                                        .data![
                                                                            i]
                                                                        .disPer! +
                                                                    '%',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .red)),
                                                        ],
                                                      ),
                                                      // if(snapshot.data![i].in_sale==true)
                                                      Text(
                                                        '${snapshot.data![i].regular_price} $currency',
                                                        style: TextStyle(
                                                          fontSize: w * 0.035,
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            dialog(context);
                                            await getItem(int.parse(snapshot
                                                .data![i].id
                                                .toString()));
                                            Navigator.pushReplacementNamed(
                                                context, 'pro');
                                          },
                                        )
                                      : Container();
                                }),
                              ),
                            ],
                          );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: mainColor,
                        backgroundColor: mainColor2,
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(translate(context, "empty", "empty")),
                    );
                  } else {
                    return Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
