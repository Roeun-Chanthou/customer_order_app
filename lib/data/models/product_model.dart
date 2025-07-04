import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int id;
  int cid;
  String name;
  String description;
  String price;
  int stock;
  String image;
  String createdAt;
  String updatedAt;
  String category;
  int categoryId;

  ProductModel({
    required this.id,
    required this.cid,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.category = 'Other',
    this.categoryId = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        cid: json['cid'] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? '',
        stock: json["stock"] ?? 0,
        image: json["image"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        category: json["category"] is Map
            ? (json["category"]["name"] ?? 'Other')
            : (json["category"] ?? 'Other'),
        categoryId: json["category"] is Map
            ? (json["category"]["id"] ?? 0)
            : (json["categoryId"] ?? 0),
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
        "category": category,
        "categoryId": categoryId,
      };
}
