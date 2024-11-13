import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class ForgetScreenService {
  static Future forgetPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}Auth/change-password'));
request.body = json.encode({
  "email": email,
  "password": password
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
    return responseBody;
}
else {
  print(response.reasonPhrase);
}


    } catch (exception) {
      print(exception);
    }
  }
}
