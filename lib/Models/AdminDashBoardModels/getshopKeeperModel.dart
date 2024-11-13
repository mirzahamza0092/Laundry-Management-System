// To parse this JSON data, do
//
//     final getAllShopKeeperModel = getAllShopKeeperModelFromJson(jsonString);

import 'dart:convert';

GetAllShopKeeperModel getAllShopKeeperModelFromJson(String str) => GetAllShopKeeperModel.fromJson(json.decode(str));

String getAllShopKeeperModelToJson(GetAllShopKeeperModel data) => json.encode(data.toJson());

class GetAllShopKeeperModel {
    List<Datum> data;

    GetAllShopKeeperModel({
        required this.data,
    });

    factory GetAllShopKeeperModel.fromJson(Map<String, dynamic> json) => GetAllShopKeeperModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String email;
    String phoneNumber;
    String password;
    int branchId;

    Datum({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.password,
        required this.branchId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        branchId: json["branchId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "branchId": branchId,
    };
}
