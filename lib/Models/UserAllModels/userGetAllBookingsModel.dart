// To parse this JSON data, do
//
//     final userGetAllBookingsModel = userGetAllBookingsModelFromJson(jsonString);

import 'dart:convert';

UserGetAllBookingsModel userGetAllBookingsModelFromJson(String str) => UserGetAllBookingsModel.fromJson(json.decode(str));

String userGetAllBookingsModelToJson(UserGetAllBookingsModel data) => json.encode(data.toJson());

class UserGetAllBookingsModel {
    List<Datum> data;

    UserGetAllBookingsModel({
        required this.data,
    });

    factory UserGetAllBookingsModel.fromJson(Map<String, dynamic> json) => UserGetAllBookingsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String startTime;
    String endTime;
    DateTime date;
    int price;
    String status;
    String type;
    String branchName;
    String programName;

    Datum({
        required this.id,
        required this.startTime,
        required this.endTime,
        required this.date,
        required this.price,
        required this.status,
        required this.type,
        required this.branchName,
        required this.programName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        date: DateTime.parse(json["date"]),
        price: json["price"],
        status: json["status"],
        type: json["type"],
        branchName: json["branchName"],
        programName: json["programName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "status": status,
        "type": type,
        "branchName": branchName,
        "programName": programName,
    };
}
