// class ProductModel {
//   final int id;
//   final String name;
//   final String description;
//   final String price;
//   final int stock;
//   final String image;
//   final int? categoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.image,
//     this.categoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       price: json['price'],
//       stock: json['stock'],
//       image: json['image'],
//       categoryId: json['category_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "name": name,
//       "description": description,
//       "price": price,
//       "stock": stock,
//       "image": image,
//       "category_id": categoryId,
//       "created_at": createdAt.toIso8601String(),
//       "updated_at": updatedAt.toIso8601String(),
//     };
//   }
// }

// final List<ProductModel> mockProducts = [
//   ProductModel(
//     id: 7,
//     name: "KDMH",
//     description: "The Shirt is very nice",
//     price: "45.00",
//     stock: 20,
//     image: "http://127.0.0.1:8000/storage/products/1749100653.jpg",
//     categoryId: null,
//     createdAt: DateTime.parse("2025-06-05T05:17:33.000000Z"),
//     updatedAt: DateTime.parse("2025-06-05T05:17:33.000000Z"),
//   ),
//   ProductModel(
//     id: 13,
//     name: "33SCRFJMS LOGO BALLOON SWEATPANTS",
//     description:
//         "33BLVDXSCARFACEXJOWMASIET EXCLUSIVE COLLABORATION\n\n33SCRFJMS LOGO BALLOON, BLACK SWEATPANTS.\n\nBALLOON FITS.\n\nFrench Terry fabric.",
//     price: "38.00",
//     stock: 100,
//     image: "http://127.0.0.1:8000/storage/products/1749102737.png",
//     categoryId: null,
//     createdAt: DateTime.parse("2025-06-05T05:52:17.000000Z"),
//     updatedAt: DateTime.parse("2025-06-05T05:52:17.000000Z"),
//   ),
// ];

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int id;
  String name;
  String description;
  String price;
  int stock;
  String image;
  String createdAt;
  String updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
