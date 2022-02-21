import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kocart/app_config/providers.dart';
import 'package:provider/provider.dart';
import 'package:kocart/models/constants.dart';
import 'package:kocart/screens/address/address.dart';
import 'package:kocart/screens/cart/orders.dart';
import 'package:kocart/screens/home_folder/home_page.dart';
import 'package:kocart/screens/lang.dart';
import 'package:kocart/screens/noti.dart';
import 'package:kocart/screens/product_info/products.dart';
import 'package:kocart/splach.dart';
import 'BottomNavWidget/change_pass.dart';
import 'lang/change_language.dart';
import 'lang/localizations.dart';
import 'models/bottomnav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: mainColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();
  await startShared();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({required this.appLanguage, Key? key}) : super(key: key);
  final AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.getProviders,
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, lang, _) {
            return AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: mainColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: st,
                  ),
                  primaryColor: mainColor,
                  checkboxTheme: CheckboxThemeData(
                    checkColor: MaterialStateProperty.all<Color>(Colors.white),
                    fillColor: MaterialStateProperty.all<Color>(mainColor),
                  ),
                  fontFamily: 'Tajawal',
                ),
                home: const Splach(),
                locale: lang.appLocal,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ar', 'EG'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routes: {
                  "pro": (ctx) => const Products(
                        fromFav: false,
                        brandId: 0,
                      ),
                  "noti": (ctx) => Notifications(),
                  "home": (ctx) => Home(),
                  "change": (ctx) => ChangePass(),
                  "address": (ctx) => const Address(),
                  "orders": (ctx) => Orders(),
                  "lang": (ctx) => LangPage(),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
