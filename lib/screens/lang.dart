import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kocart/lang/change_language.dart';
import 'package:kocart/models/bottomnav.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/models/country.dart';
import 'package:kocart/models/fav.dart';
import 'package:kocart/models/home_item.dart';
import 'package:kocart/models/user.dart';
import 'auth/country.dart';
import 'home_folder/home_page.dart';

class LangPage extends StatelessWidget {
  LangPage({Key? key}) : super(key: key);
  final String? lang = prefs.getString('language_code');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          translate(context, 'language', 'language'),
          style: TextStyle(color: Colors.white, fontSize: w * 0.04),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        leading: lang != null
            ? const BackButton(
                color: Colors.white,
              )
            : const SizedBox(),
      ),
      body: Center(
        child: SizedBox(
          width: w * 0.9,
          height: h,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              InkWell(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'English',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: w * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            radius: w * 0.03,
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: w * 0.04,
                            ),
                            backgroundColor: lang == null
                                ? Colors.white
                                : language == 'en'
                                    ? mainColor
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  dialog(context);
                  await Provider.of<AppLanguage>(context, listen: false)
                      .changeLanguage(const Locale('en'));
                  if (lang == null) {
                    if (login) {
                      getLikes();
                      getCountries();
                      await getHomeItems();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    } else {
                      getCountries();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Country(1)),
                          (route) => false);
                    }
                  } else {
                    navPop(context);
                  }
                },
              ),
              SizedBox(
                height: h * 0.02,
              ),
              InkWell(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'العربية',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: w * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            radius: w * 0.03,
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: w * 0.04,
                            ),
                            backgroundColor: lang == null
                                ? Colors.white
                                : language == 'ar'
                                    ? mainColor
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  dialog(context);
                  await Provider.of<AppLanguage>(context, listen: false)
                      .changeLanguage(const Locale('ar'));
                  // navPop(context);
                  if (lang == null) {
                    if (login) {
                      getLikes();
                      getCountries();
                      await getHomeItems();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    } else {
                      getCountries();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Country(1)),
                          (route) => false);
                    }
                  } else {
                    navPop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
