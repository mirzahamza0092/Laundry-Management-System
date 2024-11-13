// To parse this JSON data, do
//
//     final userGetMachineModel = userGetMachineModelFromJson(jsonString);

import 'dart:convert';

UserGetMachineModel userGetMachineModelFromJson(String str) => UserGetMachineModel.fromJson(json.decode(str));

String userGetMachineModelToJson(UserGetMachineModel data) => json.encode(data.toJson());

class UserGetMachineModel {
    List<Datum> data;

    UserGetMachineModel({
        required this.data,
    });

    factory UserGetMachineModel.fromJson(Map<String, dynamic> json) => UserGetMachineModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    double latitude;
    double longitude;

    Datum({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
    };
}
