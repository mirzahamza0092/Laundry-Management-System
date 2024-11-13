// To parse this JSON data, do
//
//     final bulkGetAllBranchesModel = bulkGetAllBranchesModelFromJson(jsonString);

import 'dart:convert';

BulkGetAllBranchesModel bulkGetAllBranchesModelFromJson(String str) => BulkGetAllBranchesModel.fromJson(json.decode(str));

String bulkGetAllBranchesModelToJson(BulkGetAllBranchesModel data) => json.encode(data.toJson());

class BulkGetAllBranchesModel {
    List<Datum> data;

    BulkGetAllBranchesModel({
        required this.data,
    });

    factory BulkGetAllBranchesModel.fromJson(Map<String, dynamic> json) => BulkGetAllBranchesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int branchId;
    String branchName;
    double distance;
    double latitude;
    double longitude;

    Datum({
        required this.branchId,
        required this.branchName,
        required this.distance,
        required this.latitude,
        required this.longitude,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        branchId: json["branchId"],
        branchName: json["branchName"],
        distance: json["distance"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "branchId": branchId,
        "branchName": branchName,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
    };
}
