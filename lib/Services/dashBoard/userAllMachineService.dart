import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/UserAllModels/productsModelList.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllMachineModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class UserGetAllMachines {
  static Future getAllMachines({
    required String selectedOption,
    required String bookingDate,
    required String programIdOne,
    required String capacityIdOne,
    required String programIdTwo,
    required String capacityIdTwo,
    required String programIdThree,
    required String capacityIdThree,
    required String machinesNeeded,
    required String laundryIntervals,
    required String distance,
    required String latitude,
    required String longitude,
    required List<productListModel>allProducts,
    required BuildContext context
  }) async {
     try {
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}User/getmachines'));
request.body = json.encode({
  "selectedOption": selectedOption,
  "bookingDate": bookingDate,
  "programIdOne": programIdOne,
  "capacityIdOne": capacityIdOne,
  "programIdTwo": programIdTwo,
  "capacityIdTwo": capacityIdTwo,
  "programIdThree": programIdThree,
  "capacityIdThree": capacityIdThree,
  "machinesNeeded": machinesNeeded,
  "laundryIntervals": laundryIntervals,
  "distance": distance,
  "latitude": latitude,
  "longitude": longitude,
  "items": allProducts.map((product) => product.toJson()).toList()
});

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("asaas "+responseBody);
      return userGetAllMachinesModelFromJson(responseBody); // Return response body upon success
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