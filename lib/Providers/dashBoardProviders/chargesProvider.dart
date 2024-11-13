import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllLoadCapacityModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllProgramsModel.dart';
import 'package:fyplms/Screens/dashBoard/admin/charges/chargesScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Services/dashBoard/chargesService.dart';
import 'package:fyplms/Services/dashBoard/offerService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class ChargesProvider with ChangeNotifier{
  TextEditingController cycleName=TextEditingController();
  TextEditingController cycleSpinSpeed=TextEditingController();
  TextEditingController cycleDuration=TextEditingController();
  TextEditingController cyclePrice=TextEditingController();
  TextEditingController cycleWaterTemp=TextEditingController();
  
  TextEditingController offerName=TextEditingController();
  TextEditingController offerPer=TextEditingController();
  String? startedDate,endDate,programName,programID;
  DateTime startDate=DateTime.now();TimeOfDay startTime=TimeOfDay(hour: 0, minute: 0);  DateTime endedDate=DateTime.now();TimeOfDay endTime=TimeOfDay(hour: 0, minute: 0);
  List<String> machineType=["Washer","Dryer"];
  List<String>programsList=[];
  String selectedMachineType="Washer";
  bool chargesChk=false,addOfferChk=false;



//offer

  Future<void> pickStartDateTime(BuildContext context) async {
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
      startDate=date;
      if (time != null) {
        DateTime dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        startedDate =dateTime.toIso8601String() + 'Z';
        startTime=time;
        notifyListeners();
        
      }
    }
    notifyListeners();
  }

  Future<void> pickEndDateTime(BuildContext context) async {
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
    endedDate=date;
      if (time != null) {
        DateTime dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        endDate =dateTime.toIso8601String() + 'Z';
        endTime=time;
        notifyListeners();
        
      }
    }
    notifyListeners();
  }
programOnChange(String val){
      programName=val;
      notifyListeners();
      for (int i = 0; i < programsList.length; i++) {
      if (AppConstants.getAllProgramModel!.data[i].name.toString() == val) {
        programID = AppConstants.getAllProgramModel!.data[i].id.toString();
        debugPrint(programID.toString());
      }
    }
    notifyListeners();
    }





//charges
  clearInputData(){
    cycleDuration.clear();
    cycleName.clear();
    cyclePrice.clear();
    cycleSpinSpeed.clear();
    cycleWaterTemp.clear();
    notifyListeners();
  }
  cycleTypeChange(String val){
    selectedMachineType=val;
    notifyListeners();
  }
  addCharges(
  String name,
  String type,
  String duration,
  String spinSpeed,
  String waterTemp,
  String price,
  BuildContext context,)async{
try{
    chargesChk=true;
    String spinS=spinSpeed.isEmpty?"0":spinSpeed;
    notifyListeners();
    var response=await ChargesService.addCharges(
      name: name,
      type: type,
      duration: duration,
      spinSpeed: spinS,
      waterTemp: waterTemp,
      price:price,
      context: context
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Program add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => dashBoardScreen()));
      chargesChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
  }

  addCapacity(
  String name,
  String type,
  String duration,
  String waterTemp,
  String price,
  BuildContext context,)async{
try{
    chargesChk=true;
    notifyListeners();
    var response=await ChargesService.addCapacity(
      name: name,
      type: type,
      capacity: duration,
      description: waterTemp,
      price:price,
      context: context
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Program add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => dashBoardScreen()));
      chargesChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
  }

  getAllPrograms(BuildContext context)async{
    try{
        chargesChk=true;
        notifyListeners();
          var response=await ChargesService.getAllPrograms(context: context);
          if(response!=null){
      if(response is GetAllProgramsModel){
        programsList=[];
          AppConstants.getAllProgramModel=response;
          chargesChk=false;
          AppConstants.getAllProgramModel!.data.forEach((element) {
            programName = AppConstants.getAllProgramModel!.data[0].name.toString();
            programID= AppConstants.getAllProgramModel!.data[0].id.toString();
            if (!programsList.contains(element.name.toString())) {
              programsList.add(element.name.toString());
    }
          });
          notifyListeners();
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
    notifyListeners();
  }

  addOffer(
  BuildContext context,)async{
try{
    addOfferChk=true;
    notifyListeners();
    var response=await OffersService.addOffer(
      name: offerName.text.toString(),
      startDate: startedDate.toString(),
      endDate: endDate.toString(),
      offPercentage: offerPer.text.toString(),
      programId: programID.toString(),
      programName: programName.toString(),
      context: context
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Offer add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => dashBoardScreen()));
      addOfferChk=false;
    }
    addOfferChk=false;
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
  }



  getAllLoadCapacity(BuildContext context)async{
    try{
        chargesChk=true;
        notifyListeners();
          var response=await ChargesService.getAllLoadCapacity(context: context);
          if(response!=null){
      if(response is GetAllLoadCapacityModel){
          AppConstants.getAllLoadCapacityModel=response;
          chargesChk=false;
          notifyListeners();
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
    notifyListeners();
  }
  
  updatePriceDialog(String price){
    cyclePrice.text=price;
    notifyListeners();
  }
  updateProgram(
  String id,  
  String name,
  String type,
  String duration,
  String spinSpeed,
  String waterTemp,
  String price,
  BuildContext context,)async{
try{
    chargesChk=true;
    notifyListeners();
    var response=await ChargesService.updateSpecificProgram(
      id:id,
      name: name,
      type: type,
      duration: duration,
      spinSpeed: spinSpeed,
      waterTemp: waterTemp,
      price:price,
      context: context
      );
    if(response!=null){
      getAllPrograms(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Program Update Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => chargesScreen()));
      chargesChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
  }
  updateLoadCapacity(
  String id,  
  String name,
  String price,
  BuildContext context,)async{
try{
    chargesChk=true;
    notifyListeners();
    var response=await ChargesService.updateSpecificLoadCapacity(
      id:id,
      name: name,
      price:price,
      context: context
      );
    if(response!=null){
      getAllLoadCapacity(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Program Update Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => chargesScreen()));
      chargesChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    chargesChk=false;
  }
}