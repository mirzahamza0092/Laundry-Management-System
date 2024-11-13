
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Services/AuthServices/loginService.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:http/http.dart';

class loginProvider with ChangeNotifier{
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  bool chkPassword=true;
  bool resChk=false;
  showHidePassWord(){
    chkPassword=!chkPassword;
    notifyListeners();
  }
  removeAllValues(){
    username.clear();
    password.clear();
    notifyListeners();
  }
  hitLogin(String username,String pass,BuildContext context)
  async{
    try{
      resChk=true;
      notifyListeners();
  var response=await LoginScreenService.login(emailOrUsername: username, password: pass, context: context);
  if(response!=null){
  AppConstants.loginSModel=response;
  AppConstants.token=AppConstants.loginSModel!.token.toString();
  notifyListeners();
  if(AppConstants.loginSModel!.role=="User" ){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => userDashboardScreen()),
      );
  }
  else if(AppConstants.loginSModel!.role=="Admin" ){
Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => dashBoardScreen()),
      );
  }else{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RetailerDashboard()),
      );
  }
    
  print(AppConstants.token);
  resChk=false;
    ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Login Successfully")); 
  removeAllValues();
}if(response==null){
resChk=false;
}
  notifyListeners();
  }catch (exception) {
      print(exception);
    }
    }
    

}