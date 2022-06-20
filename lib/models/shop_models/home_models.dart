import 'package:first/shared/components/constants.dart';

class HomeModel{
  bool? status;
  HomeDataModel? data;
HomeModel.fromJson(Map<String, dynamic> json)
{
  status = json['status'];
  data = HomeDataModel.fromJson(json['data']);
}

}

class HomeDataModel{
  List<BunnerModel> banners = [];
List<productModel> products = [];

HomeDataModel.fromJson(Map<String, dynamic> json)
{
json['banners'].forEach((element)
{
banners.add(element);
}
);
json['products'].forEach((element)
{
products.add(element);
}
);
}
}

class BunnerModel
{
  int? id;
  String? image;
  BunnerModel.fromJson(Map<String, dynamic> json)
{
id = json['id'];
image = json['image'];

}
}

class productModel
{

  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic disCount;
  String? image;
  String? name;
  late bool inFavourites;
  bool? inCart;
  productModel.fromJson(Map<String, dynamic> json)
{
 id = json['id'];
 price = json['price'];
 oldPrice = json['old_price'];
 disCount = json['discount'];
 image = json['image'];
 name = json['name'];
 inFavourites = json['in_favourites'];
 inCart = json['in_cart'];


}
}