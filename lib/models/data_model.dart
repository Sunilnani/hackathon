// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.products,
  });

  int categoryId;
  String categoryName;
  String imageUrl;
  List<ProductElement> products;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    imageUrl: json["image_url"],
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "image_url": imageUrl,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductElement {
  ProductElement({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.calories,
    this.imageUrl,
  });

  int productId;
  String productName;
  double productPrice;
  String productDescription;
  int calories;
  String imageUrl;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDescription: json["product_description"],
    calories: json["calories"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_description": productDescription,
    "calories": calories,
    "image_url": imageUrl,
  };
}
