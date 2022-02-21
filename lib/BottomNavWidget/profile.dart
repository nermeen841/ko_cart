// ignore_for_file: empty_catches, avoid_print, use_key_in_widget_constructors

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kocart/screens/cart/orders.dart';
import 'package:kocart/screens/lang.dart';
import 'package:provider/provider.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/info.dart';
import 'package:kocart/models/user.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/screens/about.dart';
import 'package:kocart/screens/address/address.dart';
import 'package:kocart/screens/auth/country.dart';
import 'package:kocart/screens/cart/cart.dart';
import 'package:kocart/screens/contac_us.dart';
import 'package:kocart/screens/profile_user.dart';

import 'change_pass.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Tile> tile = login
      ? [
          Tile(
              nameAr: 'الدول',
              nameEn: 'Country',
              image: 'assets/country.png',
              className: Country(2)),
          Tile(
              nameAr: 'اللغات',
              nameEn: 'Language',
              image: 'assets/lang.png',
              className: LangPage()),
          Tile(
              nameAr: 'عناويني',
              nameEn: 'My address',
              image: 'assets/myaddress.png',
              className: const Address()),
          Tile(
              nameAr: 'طلباتي',
              nameEn: 'My Orders',
              image: 'assets/01.png',
              className: Orders()),
          Tile(
              nameAr: 'تحديث حسابي',
              nameEn: 'Edit Profile',
              image: 'assets/edit.png',
              className: ProfileUser()),
          Tile(
              nameAr: 'تغيير كلمة المرور',
              nameEn: 'Change Password',
              image: 'assets/02.png',
              className: ChangePass()),

          Tile(
              nameAr: 'تواصل معنا',
              nameEn: 'Contact us',
              image: 'assets/contact.png',
              className: ContactUs()),
          Tile(
              nameAr: 'من نحن',
              nameEn: 'About app',
              keyApi: 'about',
              image: 'assets/info.png',
              className: AboutUs('About Us')),
          Tile(
              nameAr: 'مشاركة',
              nameEn: 'Share App',
              image: 'assets/shareapp.png',
              className: const SizedBox()),
          Tile(
              nameAr: 'سياسة الخصوصية',
              nameEn: 'Privacy Policy',
              keyApi: 'PrivacyPolicy',
              image: 'assets/03.png',
              className: AboutUs('Privacy Policy')),
          Tile(
              nameAr: 'الشروط و الأحكام',
              nameEn: 'Terms & Condition',
              keyApi: 'TermsAndConditions',
              image: 'assets/terms.png',
              className: AboutUs('Terms & Condition')),
          Tile(
              nameAr: 'معلومات التوصيل',
              nameEn: 'Delivery Info',
              keyApi: 'delivery',
              image: 'assets/delivery.png',
              className: AboutUs('Delivery Info')),
          Tile(
              nameAr: 'معلومات',
              nameEn: 'Information',
              keyApi: 'information',
              image: 'assets/info.png',
              className: AboutUs('Information')),
          Tile(
              nameAr: 'أسئلة',
              nameEn: 'FAQ',
              keyApi: 'question',
              image: 'assets/022.png',
              className: AboutUs('Questions')),

          Tile(
              nameAr: 'تسجيل خروج',
              nameEn: 'Sign Out',
              image: 'assets/signout.png',
              className: const SizedBox()),
          // Tile(
          //   nameAr: 'كيف تستعمل',
          //   keyApi: 'howToUse',
          //   nameEn: 'How To Use',
          //   image: 'assets/info.png',
          //   className: AboutUs('How To Use'),
          // ),
        ]
      : [
          Tile(
              nameAr: 'الدول',
              nameEn: 'Country',
              image: 'assets/country.png',
              className: Country(2)),
          Tile(
              nameAr: 'اللغات',
              nameEn: 'Language',
              image: 'assets/lang.png',
              className: LangPage()),
          Tile(
              nameAr: 'تواصل معنا',
              nameEn: 'Contact us',
              image: 'assets/contact.png',
              className: ContactUs()),
          Tile(
              nameAr: 'من نحن',
              nameEn: 'About app',
              keyApi: 'about',
              image: 'assets/info.png',
              className: AboutUs('About Us')),
          Tile(
              nameAr: 'مشاركة',
              nameEn: 'Share App',
              image: 'assets/shareapp.png',
              className: const SizedBox()),
          Tile(
              nameAr: 'سياسة الخصوصية',
              nameEn: 'Privacy Policy',
              keyApi: 'PrivacyPolicy',
              image: 'assets/03.png',
              className: AboutUs('Privacy Policy')),
          Tile(
              nameAr: 'الشروط و الأحكام',
              nameEn: 'Terms Condition',
              keyApi: 'TermsAndConditions',
              image: 'assets/terms.png',
              className: AboutUs('Terms Condition')),
          Tile(
              nameAr: 'معلومات التوصيل',
              nameEn: 'Delivery Info',
              keyApi: 'delivery',
              image: 'assets/delivery.png',
              className: AboutUs('Delivery Info')),
          Tile(
              nameAr: 'معلومات',
              nameEn: 'Information',
              keyApi: 'information',
              image: 'assets/info.png',
              className: AboutUs('Information')),
          Tile(
              nameAr: 'أسئلة',
              nameEn: 'FAQ',
              keyApi: 'question',
              image: 'assets/022.png',
              className: AboutUs('Questions')),
          Tile(
              nameAr: 'تسجيل الدخول',
              nameEn: 'LogIn',
              image: 'assets/signout.png',
              className: const SizedBox()),
          // Tile(
          //   nameAr: 'كيف تستعمل',
          //   keyApi: 'howToUse',
          //   nameEn: 'How To Use',
          //   image: 'assets/info.png',
          //   className: AboutUs('How To Use'),
          // ),
        ];

  Future<bool> getInfo(title) async {
    final String url = domain + 'infos?type=$title';
    try {
      Response response = await Dio().get(
        url,
      );
      if (response.statusCode == 200 && response.data['status'] == 1) {
        setInfo(response.data['data']);
        return true;
      }
      if (response.statusCode == 200 && response.data['status'] == 0) {
        setInfo([]);
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> logOutUser() async {
    final String url = domain + 'logout';
    try {
      await Dio().post(
        url,
        options: Options(headers: {"auth-token": auth}),
      );
      return true;
    } catch (e) {}
    return false;
  }

  Future getProfile() async {
    final String url = domain + 'profile';
    try {
      Response response = await Dio().get(
        url,
        options: Options(headers: {"auth-token": auth}),
      );
      print("user token ------------- " + auth);
      if (response.statusCode == 200) {
        Map userData = response.data;

        user = UserClass(
            id: userData['id'],
            name: userData['name'] ?? "",
            phone: userData['phone'] ?? '',
            email: userData['email'] ?? '');
        setUserId(userData['id']);
        setState(() {
          userName = user.name;
        });
        navPR(context, ProfileUser());
      } else {
        Map userData = response.data;
        user = UserClass(
            id: userData['id'],
            name: userData['name'] ?? "",
            phone: userData['phone'] ?? "",
            email: userData['email'] ?? "");
        userName = user.name;
        setUserId(userData['id']);
      }
    } catch (e) {
      navPop(context);
      final snackBar = SnackBar(
        content: Text(
          translate(context, 'snack_bar', 'try'),
        ),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cart = Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(translate(context, 'page_five', 'title')),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            "assets/shareapp.png",
            color: Colors.white,
            width: w * 0.09,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: w * 0.01),
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
                seconds: 1,
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
          SizedBox(
            width: w * 0.02,
          ),
        ],
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(right: w * 0.05, left: w * 0.05, top: h * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (login)
                  CircleAvatar(
                    backgroundColor: mainColor,
                    radius: w * 0.1,
                    child: CircleAvatar(
                      radius: w * 0.09,
                      backgroundImage: const AssetImage('assets/logo.png'),
                    ),
                  ),
                SizedBox(
                  height: h * 0.01,
                ),
                if (userName != null)
                  Text(
                    userName!,
                    style: TextStyle(
                        color: mainColor,
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                if (userName == null)
                  Text(
                    isLeft() ? 'Guest' : 'زائر',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: h * 0.01,
                ),
                Column(
                  children: List.generate(tile.length, (i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: ListTile(
                        leading: SizedBox(
                          width: w * 0.15,
                          height: w * 0.13,
                          child: Image.asset(
                            tile[i].image,
                            fit: (i == 3 || i == 5 || i == 9)
                                ? BoxFit.cover
                                : BoxFit.contain,
                            color: (i == 6 || i == 7 || i == 10 || i == 11)
                                ? mainColor
                                : null,
                          ),
                        ),
                        title: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                          child: Text(
                            isLeft() ? tile[i].nameEn : tile[i].nameAr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.06,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () async {
                          if (tile[i].nameEn == 'Edit Profile') {
                            dialog(context);
                            getProfile();
                          } else if (tile[i].nameEn == 'LogIn') {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Country(1)),
                                (route) => false);
                          } else if (tile[i].nameEn == 'Sign Out') {
                            dialog(context);
                            prefs.setBool('login', false);
                            userName = null;
                            await prefs.setString('userName', 'Guest');
                            prefs.setInt('id', 0);
                            prefs.setString('auth', '');
                            setUserId(0);
                            setAuth('');
                            setLogin(false);
                            await prefs.setBool('login', false);
                            await logOutUser();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Country(1)),
                                (route) => false);
                          } else if (tile[i].nameEn == 'Share App') {
                            // navPRRU(context, const Country(1));
                          } else {
                            if (tile[i].keyApi != null) {
                              dialog(context);
                              bool _check = await getInfo(tile[i].keyApi);
                              if (_check) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AboutUs(isLeft()
                                            ? tile[i].nameEn
                                            : tile[i].nameAr)));
                              } else {
                                Navigator.pop(context);
                                error(context);
                              }
                            } else {
                              navP(context, tile[i].className);
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tile {
  String nameAr;
  String nameEn;
  String image;
  String? keyApi;
  Widget className;
  Tile(
      {required this.nameAr,
      this.keyApi,
      required this.nameEn,
      required this.image,
      required this.className});
}
