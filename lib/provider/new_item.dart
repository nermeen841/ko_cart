// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kocart/models/constants.dart';

class NewItemProvider extends ChangeNotifier {
  List<Item> items = [];
  int pageIndex = 1;
  bool finish = false;
  String? sort;
  List sorts = [
    'Low price',
    'High price',
    'New',
  ];
  List sortsAr = [
    'سعر أقل',
    'سعر أعلي',
    'جديد',
  ];
  void clearList() {
    sort = null;
    items.clear();
    pageIndex = 1;
  }

  void sortList(int index) {
    if (index == 0) {
      items.sort((a, b) {
        return a.finalPrice.compareTo(b.finalPrice);
      });
    } else if (index == 1) {
      items.sort((a, b) {
        return b.finalPrice.compareTo(a.finalPrice);
      });
    } else {
      items.sort((a, b) {
        return a.id.compareTo(b.id);
      });
    }
    sort = sorts[index];
    notifyListeners();
  }

  void setItemsProvider(List list) {
    if (list.isEmpty || list == []) {
      finish = true;
      notifyListeners();
    } else {
      for (var e in list) {
        Item _item = Item(
            id: e['id'],
            // subCatID: e['id'].toString(),
            finalPrice: e['in_sale']
                ? num.parse(e['sale_price'].toString())
                : num.parse(e['regular_price'].toString()),
            image: imagePath + e['img'],
            nameEn: e['name_en'],
            nameAr: e['name_ar'],
            disPer: e['discount_percentage'],
            isSale: e['in_sale'],
            price: num.parse(e['regular_price'].toString()),
            salePrice: num.parse(e['sale_price'].toString()));
        items.add(_item);
      }
      pageIndex++;
      notifyListeners();
    }
  }

  Future getItems() async {
    final String url = domain + 'get-new-products?page=$pageIndex';
    try {
      Response response = await Dio().get(url);
      // print("new: ${response.data.toString()}");
      if (response.data['status'] == 1) {
        setItemsProvider(response.data['data']);
      }
      if (response.statusCode != 200) {
        await Future.delayed(const Duration(milliseconds: 700));
        getItems();
      }
    } catch (e) {
      print(e);
      await Future.delayed(const Duration(milliseconds: 700));
      getItems();
    }
  }
}

class Item {
  int id;
  String nameAr;
  String nameEn;
  num price;
  String image;
  String? disPer;
  num? salePrice;
  bool isSale;
  num finalPrice;
  List<Brands>? brands;
  String? subCatID;
  Item({
    this.brands,
    required this.id,
    required this.finalPrice,
    required this.image,
    required this.nameEn,
    required this.nameAr,
    required this.isSale,
    required this.price,
    required this.salePrice,
    required this.disPer,
  });
}

class Brands {
  int id;
  Brands({required this.id});
}
