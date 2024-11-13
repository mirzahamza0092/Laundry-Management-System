import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getshopKeeperModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificBranchModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificShopKeeperModel.dart';
import 'package:fyplms/Screens/dashBoard/admin/shopkeepers/allShopKeepers.dart';
import 'package:fyplms/Screens/dashBoard/admin/shopkeepers/shopKeeperDetailScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Services/dashBoard/branchesServices.dart';
import 'package:fyplms/Services/dashBoard/shopKeepersService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class shopKeeperProvider with ChangeNotifier{
  bool shopKeeperLoadChk=false;
  bool branchLoadChk=false;
  TextEditingController shopKeeperName=TextEditingController();
  TextEditingController shopKeeperPass=TextEditingController();
  TextEditingController shopKeeperEmail=TextEditingController();
  TextEditingController shopKeeperPhoneNumber=TextEditingController();
  TextEditingController shopKeeperBranch=TextEditingController();
  SpecificBranchModel? specificBranch;
  List<String> branchesList=[];
  String? branchSelectedValue,branchSelectedValueId;
  TextEditingController search = TextEditingController();
      dynamic searchlist = [];
    bool getspecificChk=false;
    hitupdate() {
    notifyListeners();
  }  
  detailEditChk(bool chk){
    getspecificChk=chk;
    notifyListeners();
  }
  clearInputData(){
    shopKeeperName.clear();
    shopKeeperEmail.clear();
    shopKeeperPass.clear();
    shopKeeperPhoneNumber.clear();
    notifyListeners();
  }
  getAllShopKeeper(BuildContext context)async{
    try{
        shopKeeperLoadChk=true;
        notifyListeners();
          var response=await shopKeeperServices.getshopKeepers(context: context);
          if(response!=null){
      if(response is GetAllShopKeeperModel){
          AppConstants.getShopKeeperModel=response;
          
          shopKeeperLoadChk=false;
          notifyListeners();
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    shopKeeperLoadChk=false;
    notifyListeners();
  }

  delShopKeeper(String id,BuildContext context)async{
  try{
    var response=await shopKeeperServices.delshopKeeper(context: context,id:id);
    if(response!=null){
      getAllShopKeeper(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Retailer delete Successfully")); 
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
getSpecificBranch(String id,BuildContext context) async {
    try{
    var response=await branchService.getSpecificBranch(context: context,id:id);
    if(response is SpecificBranchModel){
      specificBranch=response;
      if(getspecificChk==false){
        shopKeeperBranch.text=specificBranch!.name.toString();
        notifyListeners();
      }
      else{
      
      }
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
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
  getAllBranches(BuildContext context)async{
    try{
        branchLoadChk=true;
        notifyListeners();
          var response=await branchService.getAllBranches(context: context,branchChk: true);
          if(response!=null){
      if(response is BranchesModel){
          branchesList=[];
            AppConstants.getBranchModel=response;
          AppConstants.getBranchModel!.data.forEach((element) {
            branchSelectedValue = specificBranch!.name.toString();
            branchSelectedValueId = specificBranch!.id.toString();
            branchesList.add(element.name.toString());
          });
          branchLoadChk=false;
          notifyListeners();
          }else{
            branchLoadChk=false;
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    branchLoadChk=false;
    notifyListeners();
  }
  getSpecificShoopKeeper(String id,String name,String email,String phonenumber,String branch,BuildContext context) async {
    try{
    var response=await shopKeeperServices.getSpecificshopKeeper(context: context,id:id);
    if(response is SpecificShopKeeperModel){
      AppConstants.getSpecShopKeeperModel=response;
      if(getspecificChk==false){
      shopKeeperName.text=AppConstants.getSpecShopKeeperModel!.name.toString();
      shopKeeperEmail.text=AppConstants.getSpecShopKeeperModel!.email.toString();
      shopKeeperPhoneNumber.text=AppConstants.getSpecShopKeeperModel!.phoneNumber.toString();
      shopKeeperPass.text=AppConstants.getSpecShopKeeperModel!.password.toString();
      getSpecificBranch(branch,context);
      notifyListeners();
      }
      else{
        shopKeeperName.clear();
        shopKeeperEmail.clear();
        shopKeeperPhoneNumber.clear();
        shopKeeperBranch.clear();
        getSpecificBranch(branch,context);
      }
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => shopKeeperDetailScreen()),);
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }

  addshopKeeper(String name,String email,String pass,String number,String bId,BuildContext context)async{
try{
    shopKeeperLoadChk=true;
    notifyListeners();
    var response=await shopKeeperServices.addshopKeeper(context: context, name: name,email: email,pass:pass,number: number,branchId: bId );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Retailer add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => dashBoardScreen()));
      shopKeeperLoadChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    shopKeeperLoadChk=false;
  }
  updateSpecificShopKeper(String id,String name,String email,String pass,String number,String branchId,BuildContext context) async {
    try{
      shopKeeperLoadChk=true;
      notifyListeners();
    var response=await shopKeeperServices.updateSpecificShopKeeper(context: context, id: id, name: name, email:email,password: pass,phoneNumber: number, branchId:branchId );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Retailer Updated Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => allShopKeepers()));
      shopKeeperLoadChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    shopKeeperLoadChk=false;
    notifyListeners();
  }
}