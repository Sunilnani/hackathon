// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.productId,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.categoryId,
  });

  int productId;
  String name;
  String price;
  String imageUrl;
  String description;
  String categoryId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    name: json["name"],
    price: json["price"],
    imageUrl: json["image_url"],
    description: json["description"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "name": name,
    "price": price,
    "image_url": imageUrl,
    "description": description,
    "category_id": categoryId,
  };
}
