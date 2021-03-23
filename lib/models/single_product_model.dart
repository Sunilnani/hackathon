// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.name,
    this.price,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
  });

  String name;
  int price;
  int categoryId;
  String categoryName;
  String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
    price: json["price"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "category_id": categoryId,
    "category_name": categoryName,
    "image_url": imageUrl,
  };
}
