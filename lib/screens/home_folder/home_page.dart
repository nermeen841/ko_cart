import 'package:flutter/material.dart';
import 'package:kocart/provider/CatProvider.dart';
import 'package:kocart/provider/home.dart';
import 'package:provider/provider.dart';
import 'package:kocart/BottomNavWidget/profile.dart';
import 'package:kocart/BottomNavWidget/first_page.dart';
import 'package:kocart/BottomNavWidget/page_four.dart';
import 'package:kocart/BottomNavWidget/secound_page.dart';
import 'package:kocart/BottomNavWidget/third_page.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/user.dart';
import 'package:kocart/provider/fav_pro.dart';
import 'package:kocart/screens/auth/login.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<BottomNav> _items = [
    BottomNav(Icons.home_outlined, Icons.home_outlined, 0, 'Home', 'الرئيسية'),
    BottomNav(Icons.favorite, Icons.favorite_border, 1, 'Favorite', 'المفضلة'),
    BottomNav(Icons.menu, Icons.menu, 2, 'Categories', 'الاقسام'),
    BottomNav(Icons.search, Icons.search, 3, 'Search', 'البحث'),
    BottomNav(Icons.person, Icons.person_outline, 4, 'Profile', 'حسابي'),
  ];
  List<Widget> bottomWidget = [
    FirstPage(),
    SecPage(),
    ThirdPage(),
    PageFour(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var bottom = Provider.of<BottomProvider>(context, listen: true);
    CatProvider catProvider = Provider.of<CatProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Directionality(
        textDirection: getDirection(),
        child: Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: mainColor,
            ),
            child: BottomNavigationBar(
              backgroundColor: mainColor,
              items: List.generate(_items.length, (index) {
                return BottomNavigationBarItem(
                  activeIcon: Icon(
                    _items[index].iconSelect,
                    size: w * 0.07,
                  ),
                  icon: Icon(
                    _items[index].iconNotSelect,
                    size: w * 0.07,
                  ),
                  label: translateString(
                      _items[index].titleEn, _items[index].titleAr),
                );
              }),
              onTap: (val) async {
                if (val == 0) {
                  tabBarHome!
                      .animateTo(0, duration: const Duration(seconds: 1));
                }
                if (val != bottom.currentIndex) {
                  if (val == 4) {
                    bottom.setIndex(val);
                  }
                  if (val == 0) {
                    bottom.setIndex(val);
                    tabBarHome!
                        .animateTo(0, duration: const Duration(seconds: 1));
                  }
                  if (val == 2 || val == 3) {
                    dialog(context);
                    await catProvider.getParentCat().then((value) {
                      Navigator.pop(context);
                      bottom.setIndex(val);
                    });
                  }
                  if (val == 1) {
                    if (userId != 0) {
                      dialog(context);
                      FavItemProvider fav =
                          Provider.of<FavItemProvider>(context, listen: false);
                      fav.clearList();
                      await fav.getItems().then((value) {
                        if (value) {
                          Navigator.pop(context);
                          bottom.setIndex(val);
                        } else {
                          Navigator.pop(context);
                          error(context);
                        }
                      });
                    } else {
                      final snackBar = SnackBar(
                        content: Text(translate(context, 'snack_bar', 'login')),
                        action: SnackBarAction(
                          label: translate(context, 'buttons', 'login'),
                          disabledTextColor: Colors.yellow,
                          textColor: Colors.yellow,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (route) => false);
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                }
              },
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              currentIndex: bottom.currentIndex,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedLabelStyle:
                  TextStyle(color: Colors.white, fontSize: w * 0.03),
              unselectedLabelStyle:
                  TextStyle(color: Colors.white, fontSize: w * 0.03),
            ),
          ),
          body: SafeArea(
            child: bottomWidget[bottom.currentIndex],
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(translate(context, 'home', 'exit_app')),
            content: Text(translate(context, 'home', 'ok_mess')),
            actions: [
              // ignore: deprecated_member_use
              RaisedButton(
                color: mainColor,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(translate(context, 'home', 'no')),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                color: mainColor,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(translate(context, 'home', 'yes')),
              ),
            ],
          ),
        ) ??
        false;
  }
}
