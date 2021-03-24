// To parse this JSON data, do
//
//     final getpost = getpostFromJson(jsonString);

import 'dart:convert';

Getpost getpostFromJson(String str) => Getpost.fromJson(json.decode(str));

String getpostToJson(Getpost data) => json.encode(data.toJson());

class Getpost {
  Getpost({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory Getpost.fromJson(Map<String, dynamic> json) => Getpost(
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
  String imageUrl;

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
