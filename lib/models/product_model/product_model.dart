import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.desc,
    required this.categoryId,
    required this.isFavourite,
    this.qty,
  });

  String image;
  String id,categoryId;
  String name;
  int price;
  String desc;
  bool isFavourite;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        desc: json["desc"],
        isFavourite: false,
        qty: json["qty"],
        categoryId: json["categoryId"] ,
      );


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "desc": desc,
        "isFavourite": isFavourite,
        "qty": qty,
        "categoryId": categoryId
      };

  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? price,
    String? desc,

  }) => ProductModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      isFavourite: false,
      price: price != null? int.parse(price): this.price,
      desc: desc ?? this.desc,
      categoryId: categoryId ?? this.categoryId,
      qty: 1,
  );


}