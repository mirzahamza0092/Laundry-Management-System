import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificBranchModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetMachineModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class branchService {
  static Future getAllBranches({
    required BuildContext context,
    required bool branchChk
  }) async {
    try {
String token=AppConstants.token.toString();
var request;
 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
if(branchChk){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/branches'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/getBranches'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  if(branchChk){
  return branchesModelFromJson(resString);
  }else{
  return userGetMachineModelFromJson(resString);
  }
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }




  static Future delBranch({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('DELETE', Uri.parse('${AppConstants.apiPath}Admin/branches/$id'));

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

static Future getSpecificBranch({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/branches/$id'));

request.headers.addAll(headers);
http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
Map mapBody = jsonDecode(responseBody);
if (response.statusCode == 200) {
  return specificBranchModelFromJson(responseBody);
}
else {
  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar(mapBody["error"].toString())); 
}

    } catch (exception) {
      print(exception);
    }
  }
  static Future updateSpecificBranch({
    required BuildContext context,
    required String id,
    required String name,
    required String latitude,
    required String longitude,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('PUT', Uri.parse('${AppConstants.apiPath}Admin/branches/$id'));
request.body = json.encode({
  "name": name,
  "latitude": latitude,
  "longitude": longitude
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
static Future<String?> addBranch({
  required String name,
  required String latitude,
  required String longitude,
  required BuildContext context,
}) async {
  try {
   var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};

    var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Admin/branches'));
    request.body = json.encode({
      "name": name,
      "latitude": latitude,
      "longitude": longitude
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


}
