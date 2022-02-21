// ignore_for_file: unnecessary_string_interpolations, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:kocart/BottomNavWidget/first_page.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/cat.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/home_item.dart';
import 'package:kocart/models/products_cla.dart';
import 'package:kocart/provider/CatProvider.dart';
import 'package:kocart/provider/home.dart';
import 'package:kocart/provider/package_provider.dart';
import 'package:kocart/screens/multiple_packages.dart';
import 'package:kocart/screens/student/student.dart';
import 'package:kocart/screens/student/student_info.dart';
import 'package:kocart/screens/sub_categories_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget tabOne(BuildContext context) {
  var w = MediaQuery.of(context).size.width;
  var h = MediaQuery.of(context).size.height;
  var currency = (prefs.getString('language_code').toString() == 'en')
      ? prefs.getString('currencyEn').toString()
      : prefs.getString('currencyAr').toString();
  CatProvider catProvider = Provider.of<CatProvider>(context, listen: false);
  return SizedBox(
    width: w,
    height: h,
    child: Stack(
      children: [
        Container(
          width: w,
          height: h,
          color: Colors.white,
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (slider.isNotEmpty)
                  SizedBox(
                    width: w,
                    height: h * 0.4,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(slider[i].image),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          // overlayColor: ,
                          onTap: () async {
                            if (slider[i].inApp) {
                              if (slider[i].type) {
                                dialog(context);
                                await getItem(int.parse(slider[i].link));
                                Navigator.pushReplacementNamed(context, 'pro');
                              } else {
                                dialog(context);
                                Provider.of<NewPackageItemProvider>(context,
                                        listen: false)
                                    .clearList();
                                Provider.of<RePackageItemProvider>(context,
                                        listen: false)
                                    .clearList();
                                Provider.of<BestPackageItemProvider>(context,
                                        listen: false)
                                    .clearList();
                                await Provider.of<RePackageItemProvider>(
                                        context,
                                        listen: false)
                                    .getItems(int.parse(slider[i].link));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => MultiplePackages(
                                              id: int.parse(slider[i].link),
                                            )));
                              }
                            } else {
                              await canLaunch(slider[i].link)
                                  ? await launch(slider[i].link)
                                  : throw 'Could not launch ${slider[i].link}';
                            }
                          },
                        );
                      },
                      itemCount: slider.length,
                      autoplay: true,
                      autoplayDelay: 5000,
                    ),
                  ),
                SizedBox(
                  height: h * 0.03,
                ),
                Container(
                  width: w,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: h * 0.01,
                        bottom: h * 0.01,
                        right: w * 0.05,
                        left: w * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'cat'),
                              style: TextStyle(
                                  color: mainColor2,
                                  fontSize: w * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: isLeft()
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                        )
                                      : const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                        ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(w * 0.025),
                                  child: Text(
                                    translate(context, 'home', 'see'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Provider.of<BottomProvider>(context,
                                        listen: false)
                                    .setIndex(2);
                                // dialog(context);
                                // await CatProvider.getParentCat().then((value) {
                                //   if(value){
                                //     Navigator.pop(context);
                                //     Provider.of<BottomProvider>(context,listen: false).setIndex(2);
                                //   }else{
                                //     Navigator.pop(context);
                                //     error(context);
                                //   }
                                // });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        catProvider.categories.isNotEmpty
                            ? SizedBox(
                                width: w,
                                height: h * 0.3,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0.9,
                                  mainAxisSpacing: w * 0.08,
                                  childAspectRatio: 1.8,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: List.generate(8, (i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      margin: EdgeInsets.only(bottom: w * 0.02),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: w * 0.15,
                                              height: w * 0.2 - 10,
                                              child: Image.network(
                                                "${catProvider.categories[i].image}",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                              child: Text(
                                                prefs
                                                            .getString(
                                                                'language_code')
                                                            .toString() ==
                                                        'en'
                                                    ? catProvider
                                                        .categories[i].nameEn
                                                    : catProvider
                                                        .categories[i].nameAr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: w * 0.04),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          print(catProvider.categories[i]
                                              .subCategories.length);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubCategoriesScreen(
                                                          subcategoriesList:
                                                              catProvider
                                                                  .categories[i]
                                                                  .subCategories)));
                                          // print("subID: "+subCat[i].id.toString());
                                          // print("length: "+catProvider.categories[i].subCategories.length.toString());
                                          // dialog(context);
                                          // Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                          // Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                          // Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                          // await Provider.of<RePackageItemProvider>(context,listen: false).getItems(subCat[i].id);
                                          // setState(() {
                                          //   subCat= catProvider.categories[i].subCategories ;
                                          // });
                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                          //     (ctx)=>MultiplePackages(id: 2,)));
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              )
                            : FutureBuilder(
                                future: catProvider.getParentCat(),
                                builder: (context,
                                    AsyncSnapshot<List<Category>> snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      width: w,
                                      height: h * 0.25,
                                      child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 8,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            margin: EdgeInsets.only(
                                                bottom: w * 0.02),
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: w * 0.2,
                                                    height: w * 0.2 - 10,
                                                    child: Image.network(
                                                      "${snapshot.data![index].image}",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    // child: SvgPicture.network(categories[i].image,
                                                    //   fit: BoxFit.contain,),
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.02,
                                                    child: Text(
                                                      prefs
                                                                  .getString(
                                                                      'language_code')
                                                                  .toString() ==
                                                              'en'
                                                          ? snapshot
                                                              .data![index]
                                                              .nameEn
                                                          : snapshot
                                                              .data![index]
                                                              .nameAr,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: w * 0.04),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () async {
                                                // print("length: "+snapshot.data![index].subCategories.length.toString());
                                                // // dialog(context);
                                                // Provider.of<NewPackageItemProvider>(context,listen: false).clearList();
                                                // Provider.of<RePackageItemProvider>(context,listen: false).clearList();
                                                // Provider.of<BestPackageItemProvider>(context,listen: false).clearList();
                                                // await Provider.of<RePackageItemProvider>(context,listen: false).getItems(subCat[index].id);
                                                // // setState(() {
                                                // //   subCat = snapshot.data![index].subCategories ;
                                                // // });
                                                // Navigator.of(context).push(MaterialPageRoute(builder:
                                                //     (context)=>MultiplePackages(id:
                                                // 11,
                                                //   // categories[i].subCategories.length==0?11:subCat[i].id,
                                                // )));
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SubCategoriesScreen(
                                                                subcategoriesList:
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .subCategories)));
                                              },
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 0.9,
                                          mainAxisSpacing: w * 0.08,
                                          childAspectRatio: 1.8,
                                        ),
                                      ),
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
                                  } else {
                                    return const Text(
                                      "",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                if (subCat.isNotEmpty)
                  SizedBox(
                    height: h * 0.04,
                  ),

                if (offerEnd.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title1'),
                              style: TextStyle(
                                  color: mainColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: offerEnd.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(offerEnd[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: h * 0.07,
                                                  ),
                                                  child: Text(
                                                      translateString(
                                                          offerEnd[i].nameEn,
                                                          offerEnd[i].nameAr),
                                                      style: TextStyle(
                                                          fontSize: w * 0.035),
                                                      overflow:
                                                          TextOverflow.fade)),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              if (offerEnd[i].isSale &&
                                                  offerEnd[i].disPer != null)
                                                Text(offerEnd[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                if (offerEnd[i].isSale)
                                                  TextSpan(
                                                      text:
                                                          '${offerEnd[i].salePrice} $currency',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                if (!offerEnd[i].isSale)
                                                  TextSpan(
                                                      text:
                                                          '${offerEnd[i].price} $currency',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                // if (offerEnd[i].isSale &&
                                                //     offerEnd[i].disPer != null)
                                                //   TextSpan(
                                                //       text:
                                                //           offerEnd[i].disPer! +
                                                //               '%',
                                                //       style: const TextStyle(
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                          if (offerEnd[i].isSale)
                                            Text(
                                              '${offerEnd[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(offerEnd[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(1))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(1))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: NetworkImage(getAdsPosition(1).image),
                //           fit: BoxFit.fitWidth,
                //         ),
                //       ),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(1);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(1).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.03,
                //   ),
                if (getAds(1).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(1).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(1)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (stu.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                Container(
                  width: w,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translate(context, 'home', 'brand'),
                                style: TextStyle(
                                    color: mainColor2,
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: isLeft()
                                        ? const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                          )
                                        : const BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                          ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(w * 0.025),
                                    child: Text(
                                      translate(context, 'home', 'see'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.035,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  navP(context, Student());
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        SizedBox(
                          width: w,
                          height: h * 0.15,
                          child: ListView.builder(
                            itemCount: stu.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.01),
                                  child: Container(
                                    width: w * 0.4,
                                    height: h * 0.09,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[400]!),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: w * 0.35,
                                        height: h * 0.09,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                stu[i].image ?? ''),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  navP(
                                      context,
                                      StudentInfo(
                                        studentClass: stu[i],
                                      ));
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (newItem.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                if (newItem.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title2'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mainColor2,
                                  fontSize: w * 0.05,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: newItem.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(newItem[i].image),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      newItem[i].nameEn,
                                                      newItem[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (newItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${newItem[i].salePrice} $currency ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!newItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${newItem[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (newItem[i].isSale &&
                                                  newItem[i].disPer != null)
                                                Text(newItem[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (newItem[i].isSale)
                                            Text(
                                              '${newItem[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(newItem[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(2))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(2))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(2).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(2);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(2).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.03,
                //   ),
                if (getAds(2).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(2).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(2)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (bestItem.isNotEmpty)
                  SizedBox(
                    height: h * 0.04,
                  ),
                if (bestItem.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title3'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mainColor2,
                                  fontSize: w * 0.05,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: bestItem.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(bestItem[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      bestItem[i].nameEn,
                                                      bestItem[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (bestItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestItem[i].salePrice} $currency ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!bestItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestItem[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (bestItem[i].isSale &&
                                                  bestItem[i].disPer != null)
                                                Text(bestItem[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (bestItem[i].isSale)
                                            Text(
                                              '${bestItem[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(bestItem[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(3))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(3))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(3).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(3);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(3).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(3).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(3).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(3)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (reItem.isNotEmpty)
                  SizedBox(
                    height: h * 0.04,
                  ),
                if (reItem.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title4'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  color: mainColor2,
                                  fontFamily: 'Tajawal'),
                            ),
                            // InkWell(
                            //   child: Container(
                            //     child: Row(
                            //       children: [
                            //         Text('See All',style: TextStyle(fontSize: w*0.035,color: mainColor),),
                            //         Directionality(
                            //           textDirection: TextDirection.rtl,
                            //           child: BackButton(
                            //             onPressed: (){
                            //
                            //             },
                            //             color: mainColor,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            //   onTap: (){
                            //     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Packages()));
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: reItem.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(reItem[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      reItem[i].nameEn,
                                                      reItem[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (reItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${reItem[i].salePrice} $currency ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!reItem[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${reItem[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (reItem[i].isSale &&
                                                  reItem[i].disPer != null)
                                                Text(reItem[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (reItem[i].isSale)
                                            Text(
                                              '${reItem[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(reItem[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(4))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(4))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(4).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(4);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(4).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(4).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(4).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(4)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (bestDis.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                if (bestDis.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title5'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  color: mainColor2,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: bestDis.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(bestDis[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      bestDis[i].nameEn,
                                                      bestDis[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (bestDis[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestDis[i].salePrice} $currency ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!bestDis[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestDis[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (bestDis[i].isSale &&
                                                  bestDis[i].disPer != null)
                                                Text(bestDis[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (bestDis[i].isSale)
                                            Text(
                                              '${bestDis[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(bestDis[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(5))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(5))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(5).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(5);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(5).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(5).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(5).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(5)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (bestPrice.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                if (bestPrice.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title6'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  color: mainColor2,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: bestPrice.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                bestPrice[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      bestPrice[i].nameEn,
                                                      bestPrice[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (bestPrice[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestPrice[i].salePrice} $currency ',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!bestPrice[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${bestPrice[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (bestPrice[i].isSale &&
                                                  bestPrice[i].disPer != null)
                                                Text(bestPrice[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (bestPrice[i].isSale)
                                            Text(
                                              '${bestPrice[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(bestPrice[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(6))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(6))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(6).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(6);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),

                // if (getAds(6).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(6).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(6).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(6)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (topLikes.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                if (topLikes.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title7'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  color: mainColor2,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: topLikes.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(topLikes[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      topLikes[i].nameEn,
                                                      topLikes[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (topLikes[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${topLikes[i].salePrice} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!topLikes[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${topLikes[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (topLikes[i].isSale &&
                                                  topLikes[i].disPer != null)
                                                Text(topLikes[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (topLikes[i].isSale)
                                            Text(
                                              '${topLikes[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(topLikes[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(7))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(7))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(7).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(7);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),
                // if (getAds(7).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(7).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(7).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(7)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                if (topRate.isNotEmpty)
                  SizedBox(
                    height: h * 0.03,
                  ),
                if (topRate.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'home', 'title8'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.05,
                                  color: mainColor2,
                                  fontFamily: 'Tajawal'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.4,
                        child: ListView.builder(
                          itemCount: topRate.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              child: Padding(
                                padding: isLeft()
                                    ? EdgeInsets.only(left: w * 0.025)
                                    : EdgeInsets.only(right: w * 0.025),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: w * 0.4,
                                      height: h * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(topRate[i].image),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: h * 0.01,
                                          ),
                                          Container(
                                              constraints: BoxConstraints(
                                                maxHeight: h * 0.07,
                                              ),
                                              child: Text(
                                                  translateString(
                                                      topRate[i].nameEn,
                                                      topRate[i].nameAr),
                                                  style: TextStyle(
                                                      fontSize: w * 0.035),
                                                  overflow: TextOverflow.fade)),
                                          SizedBox(
                                            height: h * 0.005,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    if (topRate[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${topRate[i].salePrice} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    if (!topRate[i].isSale)
                                                      TextSpan(
                                                          text:
                                                              '${topRate[i].price} $currency',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                  ],
                                                ),
                                              ),
                                              if (topRate[i].isSale &&
                                                  topRate[i].disPer != null)
                                                Text(topRate[i].disPer! + '%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)),
                                            ],
                                          ),
                                          if (topRate[i].isSale)
                                            Text(
                                              '${topRate[i].price} $currency',
                                              style: TextStyle(
                                                fontSize: w * 0.035,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
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
                                await getItem(topRate[i].id);
                                Navigator.pushReplacementNamed(context, 'pro');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                // if (checkPosition(8))
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                // if (checkPosition(8))
                //   InkWell(
                //     child: Container(
                //       width: w,
                //       height: h * 0.15,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //         image: NetworkImage(getAdsPosition(8).image),
                //         fit: BoxFit.fitWidth,
                //       )),
                //     ),
                //     focusColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () async {
                //       Ads _ads = getAdsPosition(8);
                //       if (_ads.inApp) {
                //         if (_ads.type) {
                //           dialog(context);
                //           await getItem(int.parse(_ads.link));
                //           Navigator.pushReplacementNamed(context, 'pro');
                //         } else {
                //           dialog(context);
                //           Provider.of<NewPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           Provider.of<BestPackageItemProvider>(context,
                //                   listen: false)
                //               .clearList();
                //           await Provider.of<RePackageItemProvider>(context,
                //                   listen: false)
                //               .getItems(int.parse(_ads.link));
                //           Navigator.pushReplacement(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (ctx) => MultiplePackages(
                //                         id: int.parse(_ads.link),
                //                       )));
                //         }
                //       }
                //     },
                //   ),
                // if (getAds(8).isNotEmpty)
                //   SizedBox(
                //     height: h * 0.01,
                //   ),
                if (getAds(8).isNotEmpty)
                  SizedBox(
                    height: h * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                      child: Swiper(
                        itemCount: getAds(8).length,
                        itemBuilder: (BuildContext context, int i) {
                          Ads _ads = getAds(8)[i];
                          return InkWell(
                            child: Container(
                              width: w * 0.95,
                              height: h * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_ads.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (_ads.inApp) {
                                if (_ads.type) {
                                  dialog(context);
                                  await getItem(int.parse(_ads.link));
                                  Navigator.pushReplacementNamed(
                                      context, 'pro');
                                } else {
                                  dialog(context);
                                  Provider.of<NewPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<RePackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  Provider.of<BestPackageItemProvider>(context,
                                          listen: false)
                                      .clearList();
                                  await Provider.of<RePackageItemProvider>(
                                          context,
                                          listen: false)
                                      .getItems(int.parse(_ads.link));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => MultiplePackages(
                                                id: int.parse(_ads.link),
                                              )));
                                }
                              } else {
                                await canLaunch(_ads.link)
                                    ? await launch(_ads.link)
                                    : throw 'Could not launch ${_ads.link}';
                              }
                            },
                          );
                        },
                        autoplay: true,
                        autoplayDelay: 5000,
                      ),
                    ),
                  ),
                SizedBox(
                  height: h * 0.03,
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                //   child: SizedBox(
                //     width: w,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           translate(context, 'home', 'contact'),
                //           style:
                //               TextStyle(color: Colors.red, fontSize: w * 0.035),
                //         ),
                //         for (var e in homeInfo)
                //           Text(
                //             e.title,
                //             style: TextStyle(
                //                 color: Colors.grey, fontSize: w * 0.035),
                //           ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: h * 0.02,
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                //   child: Container(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: List.generate(icons.length, (i) {
                //         return InkWell(
                //           child: CircleAvatar(
                //             radius: w * 0.04,
                //             backgroundColor: Colors.white,
                //             backgroundImage: NetworkImage(icons[i].image),
                //           ),
                //           onTap: () async {
                //             await canLaunch(icons[i].link)
                //                 ? await launch(icons[i].link)
                //                 : throw 'Could not launch ${icons[i].link}';
                //           },
                //         );
                //       }),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: h * 0.15,
                // ),
              ],
            ),
          ),
        ),
        mask
            ? Positioned(
                bottom: h * 0.03,
                right: w * 0.08,
                child: CircleAvatar(
                  radius: w * 0.06,
                  backgroundColor: mainColor.withOpacity(0.7),
                  child: InkWell(
                    child: const Center(
                        child: Icon(
                      Icons.arrow_upward_outlined,
                      color: Colors.white,
                    )),
                    onTap: () {
                      controller.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
