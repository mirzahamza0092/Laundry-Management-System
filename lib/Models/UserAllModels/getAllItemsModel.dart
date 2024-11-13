// To parse this JSON data, do
//
//     final getAllItemsModel = getAllItemsModelFromJson(jsonString);

import 'dart:convert';

GetAllItemsModel getAllItemsModelFromJson(String str) => GetAllItemsModel.fromJson(json.decode(str));

String getAllItemsModelToJson(GetAllItemsModel data) => json.encode(data.toJson());

class GetAllItemsModel {
    List<Datum> data;

    GetAllItemsModel({
        required this.data,
    });

    factory GetAllItemsModel.fromJson(Map<String, dynamic> json) => GetAllItemsModel(
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
    String imageUrl;

    Datum({
        required this.id,
        required this.name,
        required this.description,
        required this.quantity,
        required this.price,
        required this.imageUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quantity": quantity,
        "price": price,
        "imageUrl": imageUrl,
    };
}
