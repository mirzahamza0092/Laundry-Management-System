import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getshopKeeperModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificBranchModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificShopKeeperModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class shopKeeperServices {
  static Future getshopKeepers({
    required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/retailers'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllShopKeeperModelFromJson(responseBody);
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




  static Future delshopKeeper({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('DELETE', Uri.parse('${AppConstants.apiPath}Admin/retailers/$id'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
 Map mapBody = jsonDecode(responseBody);
if (response.statusCode == 200) {
  return responseBody;
}
else {
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }

static Future getSpecificshopKeeper({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/retailers/$id'));

request.headers.addAll(headers);
http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
Map mapBody = jsonDecode(responseBody);
if (response.statusCode == 200) {
  return specificShopKeeperModelFromJson(responseBody);
}
else {
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
}

    } catch (exception) {
      print(exception);
    }
  }
  static Future updateSpecificShopKeeper({
    required BuildContext context,
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String branchId,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('PUT', Uri.parse('${AppConstants.apiPath}Admin/retailers/$id'));
request.body = json.encode({
  "name": name,
  "email": email,
  "phoneNumber": phoneNumber,
  "password": password,
  "branchId": branchId
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
Map mapBody = jsonDecode(responseBody);
if (response.statusCode == 200) {
  return responseBody;
}
else {
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
  print(response.reasonPhrase);
}

    } catch (exception) {
      print(exception);
    }
  }
static Future<String?> addshopKeeper({
  required String name,
  required String email,
  required String pass,
  required String number,
  required String branchId,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Admin/retailers/'));
request.body = json.encode({
  "name": name,
  "email": email,
  "phoneNumber": number,
  "password": pass,
  "branchId": branchId
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
Map mapBody = jsonDecode(responseBody);
    if (response.statusCode == 200) {
      return responseBody; // Return response body upon success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
      return null; // Return null in case of failure
    }

  } catch (exception) {
    print(exception);
    return null; // Return null in case of exception
  }
}


}
