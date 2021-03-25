// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.products,
    this.page,
    this.limit,
    this.count,
    this.totalCount,
  });

  List<ProductElement> products;
  int page;
  int limit;
  int count;
  int totalCount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    count: json["count"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "count": count,
    "total_count": totalCount,
  };
}

class ProductElement {
  ProductElement({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
  });

  int productId;
  String productName;
  int productPrice;
  String productDescription;
  int categoryId;
  String categoryName;
  String imageUrl;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDescription: json["product_description"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_description": productDescription,
    "category_id": categoryId,
    "category_name": categoryName,
    "image_url": imageUrl,
  };
}
