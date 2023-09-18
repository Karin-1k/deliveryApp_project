import 'package:get/get.dart';

class ProductsModul {
  int? totalSize;
  int? typeId;
  int? offset;
  List<Products>? products;

  ProductsModul({this.totalSize, this.typeId, this.offset, this.products});

  ProductsModul.fromJson(Map<String, dynamic> json) {
    totalSize = json['totalSize'];
    typeId = json['typeId'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  List<int>? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = 100;
    stars = json['stars'];

// parssing the img before sent to render
    List<dynamic> imgDynamic = json['img']['data'];
    List<int> i = imgDynamic.cast<int>();
    img = i;
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    typeId = json['typeId'];
  }
}
