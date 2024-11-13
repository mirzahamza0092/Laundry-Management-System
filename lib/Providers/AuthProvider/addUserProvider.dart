import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Services/AuthServices/addUserService.dart';

class addUserProvider with ChangeNotifier{
  TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
removeAllValues(){
  email.clear();
  password.clear();
  name.clear();
  phoneNumber.clear();
  notifyListeners();
}
addUser(String Uname,String Uemail,String Upassword,String Uphone,BuildContext context)async{
  try{
     var response=await SignUpScreenService.SignUp(name: Uname, email:Uemail, phone: Uphone, password: Upassword, context: context);
  if(response!=null){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),);
        removeAllValues();
            ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Account Created")); 
  }
  }catch (exception) {
      print(exception);
    }
 
}
}