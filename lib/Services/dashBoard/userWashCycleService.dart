
import 'package:flutter/material.dart';
import 'package:fyplms/Models/UserAllModels/getAllItemsModel.dart';
import 'package:fyplms/Models/UserAllModels/getAllMachineCapacitiesModel.dart';
import 'package:fyplms/Models/UserAllModels/getMachineCycleModel.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart' as http;
class userWashCycleService{
  static Future getWashCycleProgram({
    required BuildContext context,
    required bool machineChk,
  }) async {
    try {
var request;
 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
if(machineChk){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/programs/Washer'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/programs/Dryer'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getMachineCycleModelFromJson(resString);
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }
static Future getWashCapacities({
    required BuildContext context,
    required bool machineChk,
  }) async {
    try {
var request;
 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
if(machineChk){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/load-capacities/Washer'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/load-capacities/Dryer'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllMachineCapacitesModelFromJson(resString);
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }
  static Future getAllItems({
    required BuildContext context,
    required bool machineChk,
  }) async {
    try {
var request;
 print('tokeeeen ${AppConstants.token}');
var headers = {
  'Authorization': 'Bearer ${AppConstants.token}'
};
if(machineChk){
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/items/Washer'));

}else{
request = http.Request('GET', Uri.parse('${AppConstants.apiPath}User/items/Dryer'));

}

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
String resString = await response.stream.bytesToString();
if (response.statusCode == 200) {
  return getAllItemsModelFromJson(resString);
}
else {
  print(response.reasonPhrase);
}
    } catch (exception) {
      print(exception);
    }
  }
}