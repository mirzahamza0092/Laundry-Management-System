import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Services/dashBoard/bulkClothService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class BulkRequestProvider with ChangeNotifier{
  bool bulkBookingChk=false;
  TextEditingController rName=TextEditingController();
  TextEditingController rDescription=TextEditingController();
  TextEditingController rPrice=TextEditingController();
  DateTime selectedDate=DateTime.now();TimeOfDay selectedTime=TimeOfDay(hour: 0, minute: 0);
  String? dateTimes;
  getAllBranches(BuildContext context)async{
    try{
      bulkBookingChk=true;
        notifyListeners();
          var response=await BulkClothService.getAllBulBranches(context: context,);
          if(response!=null){
          AppConstants.bulkGetAllBranchesModel=response;
          bulkBookingChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    notifyListeners();
  }
  clearInputData(){
    rName.clear();
    rDescription.clear();
    rPrice.clear();
    notifyListeners();
  }
requestBulkCloth(
  String requestName,
  String description,
  String price,
  String branchId,
  String pickUpDate,
  BuildContext context,)async{
try{
    bulkBookingChk=true;
    notifyListeners();
    var response=await BulkClothService.requestForBulk(
    requestName: requestName,
    description: description,
    price:price,
    branchId: branchId,
    pickUpDate:pickUpDate,
    context: context,
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Request Send Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => userDashboardScreen()));
      bulkBookingChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    bulkBookingChk=false;
  }
  Future<void> pickDateTime(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    selectedDate=date;
      if (time != null) {
        DateTime dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        dateTimes =dateTime.toIso8601String() + 'Z';
        selectedTime=time;
        notifyListeners();
        
      }
    }
    notifyListeners();
  }
}