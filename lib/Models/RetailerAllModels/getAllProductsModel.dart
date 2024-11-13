// To parse this JSON data, do
//
//     final getAllProductsModel = getAllProductsModelFromJson(jsonString);

import 'dart:convert';

GetAllProductsModel getAllProductsModelFromJson(String str) => GetAllProductsModel.fromJson(json.decode(str));

String getAllProductsModelToJson(GetAllProductsModel data) => json.encode(data.toJson());

class GetAllProductsModel {
    List<Datum> data;

    GetAllProductsModel({
        required this.data,
    });

    factory GetAllProductsModel.fromJson(Map<String, dynamic> json) => GetAllProductsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String description;
    int quantity;
    int price;
    String productImageUrl;
    String productType;

    Datum({
        required this.id,
        required this.name,
        required this.description,
        required this.quantity,
        required this.price,
        required this.productImageUrl,
        required this.productType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        productImageUrl: json["productImageUrl"],
        productType: json["productType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quantity": quantity,
        "price": price,
        "productImageUrl": productImageUrl,
        "productType": productType,
    };
}
