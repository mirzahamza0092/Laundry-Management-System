// To parse this JSON data, do
//
//     final getAllProgramsModel = getAllProgramsModelFromJson(jsonString);

import 'dart:convert';

GetAllProgramsModel getAllProgramsModelFromJson(String str) => GetAllProgramsModel.fromJson(json.decode(str));

String getAllProgramsModelToJson(GetAllProgramsModel data) => json.encode(data.toJson());

class GetAllProgramsModel {
    List<Datum> data;

    GetAllProgramsModel({
        required this.data,
    });

    factory GetAllProgramsModel.fromJson(Map<String, dynamic> json) => GetAllProgramsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String temprature;
    String type;
    int duration;
    int spinSpeed;
    int price;
    int adminId;
    dynamic admin;

    Datum({
        required this.id,
        required this.name,
        required this.temprature,
        required this.type,
        required this.duration,
        required this.spinSpeed,
        required this.price,
        required this.adminId,
        required this.admin,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        temprature: json["temprature"],
        type: json["type"],
        duration: json["duration"],
        spinSpeed: json["spinSpeed"],
        price: json["price"],
        adminId: json["adminId"],
        admin: json["admin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "temprature": temprature,
        "type": type,
        "duration": duration,
        "spinSpeed": spinSpeed,
        "price": price,
        "adminId": adminId,
        "admin": admin,
    };
}
