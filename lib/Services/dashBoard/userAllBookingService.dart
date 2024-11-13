
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/RetailerAllModels/retailerGetAllBookingsModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllBookingsModel.dart';
import 'package:fyplms/Models/UserAllModels/usergetAllOffersModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class UserGetAllBookings{
  static Future userAllBookings({
      required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/bookings/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return userGetAllBookingsModelFromJson(responseBody);
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
 static Future updateBooking({
    required BuildContext context,
    required String id,
    required String status,
    
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request =  http.Request('PUT', Uri.parse('${AppConstants.apiPath}User/bookings/$id'));
request.body = json.encode({
  "status": status
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return true;
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


  static Future userAllOffers({
      required bool chk,
      required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request;
if(chk){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Admin/offers/'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/get-offer/'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return userGetAllOffersModelFromJson(responseBody);
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





  //retailer

  static Future retailerAllBookings({
      required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Retailer/bookings/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return retailerAllBookingsModelFromJson(responseBody);
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


  static Future retailerUpdateBooking({
    required BuildContext context,
    required String id,
    required String status,
    
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request =  http.Request('PUT', Uri.parse('${AppConstants.apiPath}Retailer/bookings/$id'));
request.body = json.encode({
  "status": status
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return true;
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