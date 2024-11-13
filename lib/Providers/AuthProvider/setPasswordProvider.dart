import 'package:flutter/material.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Services/AuthServices/forgetService.dart';

class setPasswordProvider with ChangeNotifier{
  TextEditingController email=TextEditingController();
    TextEditingController newPassword=TextEditingController();
      TextEditingController confirmPassword=TextEditingController();
      removeAllValues(){
        email.clear();
        newPassword.clear();
        confirmPassword.clear();
        notifyListeners();
      }
void forgetPass(String Uemail,String Pass,BuildContext context){
  try{
     var res=ForgetScreenService.forgetPassword(email: Uemail, password: Pass, context: context);
if(res!=null){
  print("yess");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),);
    removeAllValues();
}
  }catch (exception) {
      print(exception);
    }
 
}

}