// To parse this JSON data, do
//
//     final specificBranchModel = specificBranchModelFromJson(jsonString);

import 'dart:convert';

SpecificBranchModel specificBranchModelFromJson(String str) => SpecificBranchModel.fromJson(json.decode(str));

String specificBranchModelToJson(SpecificBranchModel data) => json.encode(data.toJson());

class SpecificBranchModel {
    int id;
    String name;
    double latitude;
    double longitude;

    SpecificBranchModel({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
    });

    factory SpecificBranchModel.fromJson(Map<String, dynamic> json) => SpecificBranchModel(
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
