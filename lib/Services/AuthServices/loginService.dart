import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/loginScreenmodel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class LoginScreenService {
  static Future login({
    required String emailOrUsername,
    required String password,
    required BuildContext context,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Auth/signin'));
request.body = json.encode({
  "password": password,
  "email": emailOrUsername
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return loginScreenModelFromJson(responseBody);
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
