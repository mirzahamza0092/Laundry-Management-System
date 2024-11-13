import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class OffersService{
    static Future<String?> addOffer({
  required String name,
  required String startDate,
  required String endDate,
  required String offPercentage,
  required String programId,
  required String programName,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Admin/offers/'));
request.body = json.encode({
  "name": name,
  "startDate": startDate,
  "endDate": endDate,
  "offPercentage": offPercentage,
  "status": "Active",
  "programId": programId,
  "programName": programName
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

}