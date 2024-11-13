import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificBranchModel.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/addBranchScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/allBranchScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Services/dashBoard/branchesServices.dart';
import 'package:fyplms/Utils/AppConstants.dart';

import '../../Screens/dashBoard/admin/branches/branchesDetails.dart';

class branchesProvider with ChangeNotifier{
  List<String>branchesList=[];
    TextEditingController search = TextEditingController();
      dynamic searchlist = [];
  TextEditingController branchName=TextEditingController();
  TextEditingController branchLatitude=TextEditingController();
  TextEditingController branchLongitude=TextEditingController();
  bool branchLoadChk=false,getspecificChk=false;
  String? branchSelectedValue,branchSelectedValueId;
  BranchesModel? allBranchesRes;
  SpecificBranchModel? specificBranch;
  bool addBranchChk=false;
   hitupdate() {
    notifyListeners();
  }
 changeBranchNameValue(name) {
    branchSelectedValue = name;
    for (int i = 0; i < branchesList.length; i++) {
      if (AppConstants.getBranchModel!.data[i].name.toString() == name) {
        branchSelectedValueId = AppConstants.getBranchModel!.data[i].id.toString();
        debugPrint(branchSelectedValueId.toString());
      }
    }
    notifyListeners();
  }
  clearInputData(){
    branchName.clear();
      branchLatitude.clear();
      branchLongitude.clear();
  
  }
  getAllBranches(BuildContext context)async{
    try{
        branchLoadChk=true;
        notifyListeners();
          var response=await branchService.getAllBranches(context: context,branchChk: true);
          if(response!=null){
      if(response is BranchesModel){
            allBranchesRes=response;
            AppConstants.getBranchModel=allBranchesRes;
          AppConstants.getBranchModel!.data.forEach((element) {
            branchSelectedValue = AppConstants.getBranchModel!.data[0].name.toString();
            branchSelectedValueId = AppConstants.getBranchModel!.data[0].id.toString();
            branchesList.add(element.name.toString());
          });
          branchLoadChk=false;
          notifyListeners();
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    branchLoadChk=false;
    notifyListeners();
  }
  addBranches(String bName,String bLatitude,String bLogitude,BuildContext context)async{
try{
    addBranchChk=true;
    notifyListeners();
    var response=await branchService.addBranch(context: context, name: bName, latitude: bLatitude, longitude: bLogitude);
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Branch add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => dashBoardScreen()));
      addBranchChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    addBranchChk=false;
  }
  
  delBranch(String id,BuildContext context)async{
   try{
    var response=await branchService.delBranch(context: context,id:id);
    if(response!=null){
      getAllBranches(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Branch delete Successfully")); 
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
  detailEditChk(bool chk){
    getspecificChk=chk;
    notifyListeners();
  }
  getSpecificBranch(String id,String name,String lat,String long,BuildContext context) async {
    try{
    var response=await branchService.getSpecificBranch(context: context,id:id);
    if(response is SpecificBranchModel){
      specificBranch=response;
      if(getspecificChk==false){
      branchName.text=specificBranch!.name.toString();
      branchLatitude.text=specificBranch!.latitude.toString();
      branchLongitude.text=specificBranch!.longitude.toString();
      }
      else{
        branchName.clear();
        branchLatitude.clear();
        branchLongitude.clear();
      }
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => branchDetailScreen()));
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
  updateSpecificBranch(String id,String name,String lat,String long,BuildContext context) async {
    try{
      addBranchChk=true;
      notifyListeners();
    var response=await branchService.updateSpecificBranch(context: context, id: id, name: name, latitude: lat, longitude: long);
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Branch Updated Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => allBranchScreen()));
      addBranchChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    addBranchChk=false;
    notifyListeners();
  }
}