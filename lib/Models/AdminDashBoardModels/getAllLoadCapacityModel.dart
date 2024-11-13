// To parse this JSON data, do
//
//     final getAllLoadCapacityModel = getAllLoadCapacityModelFromJson(jsonString);

import 'dart:convert';

GetAllLoadCapacityModel getAllLoadCapacityModelFromJson(String str) => GetAllLoadCapacityModel.fromJson(json.decode(str));

String getAllLoadCapacityModelToJson(GetAllLoadCapacityModel data) => json.encode(data.toJson());

class GetAllLoadCapacityModel {
    List<Datum> data;

    GetAllLoadCapacityModel({
        required this.data,
    });

    factory GetAllLoadCapacityModel.fromJson(Map<String, dynamic> json) => GetAllLoadCapacityModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    int capacity;
    String description;
    String type;
    int price;
    dynamic adminId;
    dynamic admin;

    Datum({
        required this.id,
        required this.name,
        required this.capacity,
        required this.description,
        required this.type,
        required this.price,
        required this.adminId,
        required this.admin,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        capacity: json["capacity"],
        description: json["description"],
        type: json["type"],
        price: json["price"],
        adminId: json["adminId"],
        admin: json["admin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "capacity": capacity,
        "description": description,
        "type": type,
        "price": price,
        "adminId": adminId,
        "admin": admin,
    };
}
