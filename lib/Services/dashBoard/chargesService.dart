import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllLoadCapacityModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllProgramsModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class ChargesService{
  static Future<String?> addCharges({
  required String name,
  required String type,
  required String duration,
  required String spinSpeed,
  required String waterTemp,
  required String price,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Admin/programs/'));
request.body = json.encode({
  "name": name,
  "type": type,
  "duration": duration,
  "spinSpeed": spinSpeed,
  "temprature": waterTemp,
  "price": price
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 204) {
      return responseBody; // Return response body upon success
    } else {
    Map mapBody = jsonDecode(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
      return null; // Return null in case of failure
    }

  } catch (exception) {
    print(exception);
    return null; // Return null in case of exception
  }
}

 static Future<String?> addCapacity({
  required String name,
  required String type,
  required String capacity,
  required String description,
  required String price,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Admin/load-capacity/'));
request.body = json.encode({
  "name": name,
  "capacity": capacity,
  "description": description,
  "type": type,
  "price": price
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return responseBody; // Return response body upon success
    } else {
    Map mapBody = jsonDecode(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
      return null; // Return null in case of failure
    }

  } catch (exception) {
    print(exception);
    return null; // Return null in case of exception
  }
}

static Future getAllPrograms({
    required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/programs/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllProgramsModelFromJson(responseBody);
}
else {
  Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
}

    } catch (exception) {
      print(exception);
    }
  }
static Future getAllLoadCapacity({
    required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/load-capacity/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllLoadCapacityModelFromJson(responseBody);
}
else {
  Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
}

    } catch (exception) {
      print(exception);
    }
  }
  static Future updateSpecificProgram({
  required String id,  
  required String name,
  required String type,
  required String duration,
  required String spinSpeed,
  required String waterTemp,
  required String price,
  required BuildContext context,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('PUT', Uri.parse('${AppConstants.apiPath}Admin/programs/$id'));
request.body = json.encode({
  "name": name,
  "type": type,
  "duration": duration,
  "spinSpeed": spinSpeed,
  "airSpeed": spinSpeed,
  "waterTemp": waterTemp,
  "airTemp": waterTemp,
  "price": price
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 204) {
  return responseBody;
}
else {
Map mapBody = jsonDecode(responseBody);
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }
  static Future updateSpecificLoadCapacity({
  required String id,  
  required String name,
  required String price,
  required BuildContext context,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('PUT', Uri.parse('${AppConstants.apiPath}Admin/load-capacity/$id'));
request.body = json.encode({
  "name": name,
  "price": price
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
                      appSnackBar(mapBody["error"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }
}