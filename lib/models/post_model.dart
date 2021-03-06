// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    this.categoryId,
    this.name,
    this.imageUrl,
  });

  int categoryId;
  String name;
  dynamic imageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryId: json["category_id"],
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
    "image_url": imageUrl,
  };
}
