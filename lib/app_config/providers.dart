
import 'package:kocart/provider/CatProvider.dart';
import 'package:kocart/provider/address.dart';
import 'package:kocart/provider/best_item.dart';
import 'package:kocart/provider/cart_provider.dart';
import 'package:kocart/provider/fav_pro.dart';
import 'package:kocart/provider/home.dart';
import 'package:kocart/provider/map.dart';
import 'package:kocart/provider/new_item.dart';
import 'package:kocart/provider/offer_item.dart';
import 'package:kocart/provider/package_provider.dart';
import 'package:kocart/provider/recommended_item.dart';
import 'package:kocart/provider/scroll_up_home.dart';
import 'package:kocart/provider/student_product.dart';
import 'package:kocart/provider/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(create: (context) => CatProvider()),
    ChangeNotifierProvider(create: (context) => NewItemProvider()),
    ChangeNotifierProvider(create: (context) => StudentItemProvider()),
    ChangeNotifierProvider(create: (context) => StudentProvider()),
    ChangeNotifierProvider(create: (context) => ReItemProvider()),
    ChangeNotifierProvider(create: (context) => FavItemProvider()),
    ChangeNotifierProvider(create: (context) => ScrollUpHome()),
    ChangeNotifierProvider(create: (context) => BestItemProvider()),
    ChangeNotifierProvider(create: (context) => BottomProvider()),
    ChangeNotifierProvider(create: (context) => OfferItemProvider()),
    ChangeNotifierProvider(create: (context) => NewPackageItemProvider()),
    ChangeNotifierProvider(create: (context) => BestPackageItemProvider()),
    ChangeNotifierProvider(create: (context) => RePackageItemProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => MapProvider()),
    ChangeNotifierProvider(create: (context) => AddressProvider()),
  ];

}