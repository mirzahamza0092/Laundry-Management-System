// To parse this JSON data, do
//
//     final getAllMachinesModel = getAllMachinesModelFromJson(jsonString);

import 'dart:convert';

GetAllMachinesModel getAllMachinesModelFromJson(String str) => GetAllMachinesModel.fromJson(json.decode(str));

String getAllMachinesModelToJson(GetAllMachinesModel data) => json.encode(data.toJson());

class GetAllMachinesModel {
    List<Datum> data;

    GetAllMachinesModel({
        required this.data,
    });

    factory GetAllMachinesModel.fromJson(Map<String, dynamic> json) => GetAllMachinesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String machineCode;
    String status;
    int price;
    String machineType;
    String loadCapacityName;

    Datum({
        required this.id,
        required this.machineCode,
        required this.status,
        required this.price,
        required this.machineType,
        required this.loadCapacityName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        machineCode: json["machineCode"],
        status: json["status"],
        price: json["price"],
        machineType: json["machineType"],
        loadCapacityName: json["loadCapacityName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "machineCode": machineCode,
        "status": status,
        "price": price,
        "machineType": machineType,
        "loadCapacityName": loadCapacityName,
    };
}
