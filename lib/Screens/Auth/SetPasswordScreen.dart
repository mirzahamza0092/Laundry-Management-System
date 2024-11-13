import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/AuthProvider/setPasswordProvider.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
   GlobalKey<FormState> setPasswordscreenkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0),
              child: Consumer<setPasswordProvider>(builder: (context,provider,child){
          return Form(
            key: setPasswordscreenkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image:AssetImage(ImagePath.appLogo),width: 150,height: 150,)),
              Center(child: commonText(text: "Set Password",size: 20,color: AppColors.blackColor,fontweight: FontWeight.w500)),
              30.sh,
                      commonText(text: "Email", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                          10.sh,
                    CommonTextField(
                      controller: provider.email,
                      hinttext: "Email",
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Your Username';
                                  }
                                
                                  final emailRegex = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                
                                  if (emailRegex.hasMatch(value)) {
                                    return null; // valid email
                                  } else if (value.length < 3 || value.length > 20) {
                                    return 'Username should be between 3 and 20 characters';
                                  }
                                
                                  return null; // valid username
                                },
                    ),
                    10.sh,
                    commonText(text: "Password", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                          10.sh,
                    CommonTextField(
                      controller: provider.newPassword,
                      hinttext: "Password",
                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password can't be empty";
                                      } else if (value.length < 3) {
                                        return "Password must be greater than 3 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                    ),
                    10.sh,
                     commonText(text: "Confirm Password", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                          10.sh,
                    CommonTextField(
                      controller: provider.confirmPassword,
                      hinttext: "Confirm Password",
                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Confirm Password can't be empty";
                                      } else if (value.length < 3) {
                                        return "Confirm Password must be greater than 3 characters";
                                      } else if (value!=provider.newPassword.text) {
                                        return "Confirm Password not matched to password ";
                                      } else {
                                        return null;
                                      }
                                    },
                    ),20.sh,
                    CommonButton(onPressed: (){
                      if(setPasswordscreenkey.currentState!.validate()){
                    provider.forgetPass(provider.email.text.toString(), provider.newPassword.text.toString(), context);
                      }
                    }, width: width(context), text: "Change Password",color: AppColors.primaryColor,),
                    20.sh,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        commonText(text: "Back to", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sw,
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) =>  LoginScreen())); 
                          },
                          child: commonText(text: "LogIn", size: 14, color: AppColors.primaryColor, fontweight: FontWeight.w600))
                      ],),
                    
            ],
            ),
          ) ;
            
          })
            ))),
      ));
  }
}