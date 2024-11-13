import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/UserAllModels/productsModelList.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllMachineModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class BookingService {

   static Future bookingDone({
    required String selectedOption,
    required String branchId,
    required String laundryIntervals,
    required List<productListModel>allProducts,
    required List<MachinesList> machinesList,
    required BuildContext context
  }) async {
    try {
      String priceAfterDiscount=AppConstants.userGetAllMachinesModel!.data.discountedPrice.toString();
      String totalPrice=AppConstants.userGetAllMachinesModel!.data.price.toString();
      String machineId=AppConstants.userGetAllMachinesModel!.data.machinesList[0].machineId.toString();
      String programId=AppConstants.userGetAllMachinesModel!.data.machinesList[0].programId.toString();
      String bookingDate=AppConstants.userGetAllMachinesModel!.data.machinesList[0].bookingDate.toIso8601String();
      String endDate= AppConstants.userGetAllMachinesModel!.data.machinesList[0].endDate.toIso8601String();
      String branchId2=AppConstants.userGetAllMachinesModel!.data.machinesList[0].branchId.toString();
  var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${AppConstants.token}'
};
var request = http.Request('POST', Uri.parse('${AppConstants.apiPath}User/bookings'));
request.body = json.encode({
  "branchId": branchId,
  "laundryIntervals": laundryIntervals,
  "machineType": selectedOption,
  "priceAfterDiscount":priceAfterDiscount ,
  "totalPrice":totalPrice,
  "machines":machinesList.map((product) => product.toJson()).toList(),
  "items": allProducts.map((product) => product.toJson()).toList()
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