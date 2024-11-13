import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllLoadCapacityModel.dart';
import 'package:fyplms/Models/RetailerAllModels/getAllMachinesModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;

class MachinesService {
  static Future getAllMachines({
    required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Retailer/machines/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();


if (response.statusCode == 200) {
  return getAllMachinesModelFromJson(responseBody);
}
else {
  Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["errorMsg"].toString())); 
}

    } catch (exception) {
      print(exception);
    }
  }

  static Future<String?> addMachines({
  required String machineCode,
  required String loadCapacity,
  required String machineType,
  required String status,
  required String price,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Retailer/machines/'));
request.body = json.encode({
  "machineCode": machineCode,
  "loadCapacity": loadCapacity,
  "machineType": machineType,
  "status": status,
  "price": "0"
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return responseBody; // Return response body upon success
    } else {
    Map mapBody = jsonDecode(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["errorMsg"].toString())); 
      return null; // Return null in case of failure
    }

  } catch (exception) {
    print(exception);
    return null; // Return null in case of exception
  }
}
static Future getLoadCapacities({
    required BuildContext context,
    required String type,
  }) async {
    try {
var request;
 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
if(type=="Washer"){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Retailer/load-capacity/Washer'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Retailer/load-capacity/Dryer'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllLoadCapacityModelFromJson(resString);
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }
  static Future delMachine({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('DELETE', Uri.parse('${AppConstants.apiPath}Retailer/machines/$id'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return responseBody;
}
else {
 Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["errorMsg"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }
  static Future updateMachine({
    required BuildContext context,
    required String id,
    required String status
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request =  http.Request('PUT', Uri.parse('${AppConstants.apiPath}Retailer/machines/$id'));
request.body = json.encode({
  "status": status
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return responseBody;
}
else {
 Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["errorMsg"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }
}