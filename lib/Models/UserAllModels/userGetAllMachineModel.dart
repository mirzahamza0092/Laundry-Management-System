// To parse this JSON data, do
//
//     final userGetAllMachinesModel = userGetAllMachinesModelFromJson(jsonString);

import 'dart:convert';

UserGetAllMachinesModel userGetAllMachinesModelFromJson(String str) => UserGetAllMachinesModel.fromJson(json.decode(str));

String userGetAllMachinesModelToJson(UserGetAllMachinesModel data) => json.encode(data.toJson());

class UserGetAllMachinesModel {
    Data data;

    UserGetAllMachinesModel({
        required this.data,
    });

    factory UserGetAllMachinesModel.fromJson(Map<String, dynamic> json) => UserGetAllMachinesModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    List<BranchesList> branchesList;
    List<MachinesList> machinesList;
    int price;
    int discountedPrice;

    Data({
        required this.branchesList,
        required this.machinesList,
        required this.price,
        required this.discountedPrice,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        branchesList: List<BranchesList>.from(json["branchesList"].map((x) => BranchesList.fromJson(x))),
        machinesList: List<MachinesList>.from(json["machinesList"].map((x) => MachinesList.fromJson(x))),
        price: json["price"],
        discountedPrice: json["discountedPrice"],
    );

    Map<String, dynamic> toJson() => {
        "branchesList": List<dynamic>.from(branchesList.map((x) => x.toJson())),
        "machinesList": List<dynamic>.from(machinesList.map((x) => x.toJson())),
        "price": price,
        "discountedPrice": discountedPrice,
    };
}

class BranchesList {
    String branchName;
    double distance;
    int branchId;

    BranchesList({
        required this.branchName,
        required this.distance,
        required this.branchId,
    });

    factory BranchesList.fromJson(Map<String, dynamic> json) => BranchesList(
        branchName: json["branchName"],
        distance: json["distance"]?.toDouble(),
        branchId: json["branchId"],
    );

    Map<String, dynamic> toJson() => {
        "branchName": branchName,
        "distance": distance,
        "branchId": branchId,
    };
}

class MachinesList {
    int machineId;
    int programId;
    DateTime bookingDate;
    DateTime endDate;
    int branchId;

    MachinesList({
        required this.machineId,
        required this.programId,
        required this.bookingDate,
        required this.endDate,
        required this.branchId,
    });

    factory MachinesList.fromJson(Map<String, dynamic> json) => MachinesList(
        machineId: json["machineId"],
        programId: json["programId"],
        bookingDate: DateTime.parse(json["bookingDate"]),
        endDate: DateTime.parse(json["endDate"]),
        branchId: json["branchId"],
    );

    Map<String, dynamic> toJson() => {
        "machineId": machineId,
        "programId": programId,
        "bookingDate": bookingDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "branchId": branchId,
    };
}
