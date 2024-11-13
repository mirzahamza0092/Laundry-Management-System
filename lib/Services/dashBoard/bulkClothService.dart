import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/UserAllModels/bulkGetAllBranchesModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class BulkClothService{
  static Future getAllBulBranches({
    required BuildContext context,
  }) async {
    try {

 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/getAllBranches?latitude=33.6428&longitude=73.0706'));


request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return bulkGetAllBranchesModelFromJson(resString);
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }


  static Future<String?> requestForBulk({
  required String requestName,
  required String description,
  required String price,
  required String branchId,
  required String pickUpDate,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}User/bulkCloth/'));
request.body = json.encode({
  "requestName": requestName,
  "description": description,
  "price": price,
  "branchId": branchId,
  "pickUpDate":pickUpDate
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