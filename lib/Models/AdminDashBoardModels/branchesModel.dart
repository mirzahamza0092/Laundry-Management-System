// To parse this JSON data, do
//
//     final branchesModel = branchesModelFromJson(jsonString);

import 'dart:convert';

BranchesModel branchesModelFromJson(String str) => BranchesModel.fromJson(json.decode(str));

String branchesModelToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
    List<Datum> data;

    BranchesModel({
        required this.data,
    });

    factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
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
    bool isAssigned;

    Datum({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
        required this.isAssigned,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isAssigned: json["isAssigned"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "isAssigned": isAssigned,
    };
}
