// To parse this JSON data, do
//
//     final userGetAllOffersModel = userGetAllOffersModelFromJson(jsonString);

import 'dart:convert';

UserGetAllOffersModel userGetAllOffersModelFromJson(String str) => UserGetAllOffersModel.fromJson(json.decode(str));

String userGetAllOffersModelToJson(UserGetAllOffersModel data) => json.encode(data.toJson());

class UserGetAllOffersModel {
    List<Datum> data;

    UserGetAllOffersModel({
        required this.data,
    });

    factory UserGetAllOffersModel.fromJson(Map<String, dynamic> json) => UserGetAllOffersModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    DateTime startDate;
    DateTime endDate;
    int offPercentage;
    String status;
    int programId;
    String programName;

    Datum({
        required this.id,
        required this.name,
        required this.startDate,
        required this.endDate,
        required this.offPercentage,
        required this.status,
        required this.programId,
        required this.programName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        offPercentage: json["offPercentage"],
        status: json["status"],
        programId: json["programId"],
        programName: json["programName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "offPercentage": offPercentage,
        "status": status,
        "programId": programId,
        "programName": programName,
    };
}
