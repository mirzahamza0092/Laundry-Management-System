// To parse this JSON data, do
//
//     final specificShopKeeperModel = specificShopKeeperModelFromJson(jsonString);

import 'dart:convert';

SpecificShopKeeperModel specificShopKeeperModelFromJson(String str) => SpecificShopKeeperModel.fromJson(json.decode(str));

String specificShopKeeperModelToJson(SpecificShopKeeperModel data) => json.encode(data.toJson());

class SpecificShopKeeperModel {
    int id;
    String name;
    String email;
    String password;
    String phoneNumber;

    SpecificShopKeeperModel({
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.phoneNumber,
    });

    factory SpecificShopKeeperModel.fromJson(Map<String, dynamic> json) => SpecificShopKeeperModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
    };
}
