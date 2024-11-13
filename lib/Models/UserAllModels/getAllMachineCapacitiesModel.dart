// To parse this JSON data, do
//
//     final getAllMachineCapacitesModel = getAllMachineCapacitesModelFromJson(jsonString);

import 'dart:convert';

GetAllMachineCapacitesModel getAllMachineCapacitesModelFromJson(String str) => GetAllMachineCapacitesModel.fromJson(json.decode(str));

String getAllMachineCapacitesModelToJson(GetAllMachineCapacitesModel data) => json.encode(data.toJson());

class GetAllMachineCapacitesModel {
    List<Datum> data;

    GetAllMachineCapacitesModel({
        required this.data,
    });

    factory GetAllMachineCapacitesModel.fromJson(Map<String, dynamic> json) => GetAllMachineCapacitesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    int loadCapacity;
    String loadCapacityDescription;
    int price;

    Datum({
        required this.id,
        required this.name,
        required this.loadCapacity,
        required this.loadCapacityDescription,
        required this.price,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        loadCapacity: json["loadCapacity"],
        loadCapacityDescription: json["loadCapacityDescription"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "loadCapacity": loadCapacity,
        "loadCapacityDescription": loadCapacityDescription,
        "price": price,
    };
}
