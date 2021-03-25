// To parse this JSON data, do
//
//     final patchcategory = patchcategoryFromJson(jsonString);

import 'dart:convert';

Patchcategory patchcategoryFromJson(String str) => Patchcategory.fromJson(json.decode(str));

String patchcategoryToJson(Patchcategory data) => json.encode(data.toJson());

class Patchcategory {
  Patchcategory({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory Patchcategory.fromJson(Map<String, dynamic> json) => Patchcategory(
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
