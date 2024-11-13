import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/RetailerAllModels/getAllProductsModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class ProductService{
  static Future<String?> addProducts({
  required String name,
  required String description,
  required String machineType,
  required String price,
  required String quantity,
  required String img,
  required BuildContext context,
}) async {
  try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request =  http.MultipartRequest('POST', Uri.parse('${AppConstants.apiPath}Retailer/items/'));
Uint8List emptyFileBytes = Uint8List(0);
request.fields.addAll({
  'name': name,
  'description': description,
  'type': machineType,
  'price': price,
  'quantity': quantity
});
request.files.add(await http.MultipartFile.fromBytes(
  'image',
   emptyFileBytes,
   filename: 'empty.txt',
   ));
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


static Future getAllProducts({
    required BuildContext context
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('GET', Uri.parse('${AppConstants.apiPath}Retailer/items/'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String responseBody = await response.stream.bytesToString();


if (response.statusCode == 200) {
  return getAllProductsModelFromJson(responseBody);
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


  static Future delProduct({
    required BuildContext context,
    required String id
  }) async {
    try {
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('DELETE', Uri.parse('${AppConstants.apiPath}Retailer/items/$id'));

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
  static Future updateProduct({
    required BuildContext context,
    required String id,
    required String name,
    required String description,
    required String quntity,
    required String price,
    required String productType,
    required String productImage,
  }) async {
    try {
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request =  http.Request('PUT', Uri.parse('${AppConstants.apiPath}Retailer/items/$id'));
request.body = json.encode({
  "name": name,
  "description": description,
  "quantity": quntity,
  "price": price,
  "productType": productType,
  "productImage": productImage
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