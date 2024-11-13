import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Services/dashBoard/MachinesService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class MachineProvider with ChangeNotifier{
  TextEditingController machineCode=TextEditingController();
  TextEditingController machineCapacity=TextEditingController();
  TextEditingController machinePrice=TextEditingController();
  bool machineLoadChk=false;
  TextEditingController search = TextEditingController();
  dynamic searchlist = [];
  String? selectedCapacity,selectedCapacityId;
  List<String> loadCapacityList=[];
  String selectedStatus="Active";
  List<String> statusList=["Active","Block"];
  String selectedMachineType="Washer";
  List<String> machinetypeList=["Washer","Dryer"];
  String machineStatus="";
  hitupdate() {
    notifyListeners();
  }  
  clearInputData(){
    machineCapacity.clear();
    machineCode.clear();
    machinePrice.clear();
    notifyListeners();
  }
  typeChange(String val,BuildContext context){
    selectedMachineType=val;
    getAllLoadCapacities(context);
    notifyListeners();
  }
  statusChange(String val){
    selectedStatus=val;
    notifyListeners();
  }
  loadCapacityValue(String val){
      selectedCapacity=val;
      notifyListeners();
      for (int i = 0; i < loadCapacityList.length; i++) {
      if (AppConstants.getAllLoadCapacityModel!.data[i].name.toString() == val) {
        selectedCapacityId = AppConstants.getAllLoadCapacityModel!.data[i].id.toString();
        debugPrint(selectedCapacityId.toString());
      }
    }
      print(selectedCapacity);
      notifyListeners();
    }
  getAllLoadCapacities(BuildContext context)async{
    try{
      machineLoadChk=true;
        notifyListeners();
          var response=await MachinesService.getLoadCapacities(context: context,type: selectedMachineType);
          if(response!=null){
            loadCapacityList=[];
            AppConstants.getAllLoadCapacityModel=response;
            AppConstants.getAllLoadCapacityModel!.data.forEach((element) {
            selectedCapacity = AppConstants.getAllLoadCapacityModel!.data[0].name.toString();
            selectedCapacityId = AppConstants.getAllLoadCapacityModel!.data[0].id.toString();
            loadCapacityList.add(element.name.toString());
          });
          machineLoadChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    machineLoadChk=false;
    notifyListeners();
  }
  addMachine(
  String machineCode,
  String loadCapacity,
  String machineType,
  String status,
  String price,
  BuildContext context,)async{
try{
    machineLoadChk=true;
    notifyListeners();
    var response=await MachinesService.addMachines(
      machineCode: machineCode,
      loadCapacity: loadCapacity,
      machineType: machineType,
      status: status,
      price:price,
      context: context
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Machine add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => RetailerDashboard()));
      machineLoadChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    machineLoadChk=false;
  }
  getAllMachines(BuildContext context)async{
    try{
      machineLoadChk=true;
        notifyListeners();
          var response=await MachinesService.getAllMachines(context: context,);
          if(response!=null){
            AppConstants.getAllMachinesModel=response;
          machineLoadChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    machineLoadChk=false;
    notifyListeners();
  }
  
  delMachine(String id,BuildContext context)async{
  try{
    var response=await MachinesService.delMachine(context: context,id:id);
    if(response!=null){
      getAllMachines(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Machine delete Successfully")); 
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
  machineStatusChange(String val){
    machineStatus=val;
    notifyListeners();
  }
  updateMachine(String id,BuildContext context)async{
  try{
    var response=await MachinesService.updateMachine(context: context,id:id,status: machineStatus);
    if(response!=null){
      getAllMachines(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Machine Update Successfully")); 
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
}