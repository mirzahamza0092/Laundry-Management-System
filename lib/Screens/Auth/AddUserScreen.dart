import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/AuthProvider/addUserProvider.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  GlobalKey<FormState> AddUserscreenkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0),
            child: Consumer<addUserProvider>(builder: (context,provider,child){
        return Form(
          key: AddUserscreenkey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  10.sh,
                Center(child: Image(image:AssetImage(ImagePath.appLogo),width: 150,height: 150,)),
                Center(child: commonText(text: "Sign Up", size: 20, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                20.sh,
                
                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                      10.sh,
                CommonTextField(
                  controller: provider.name,
                  hinttext: "Name",
                 validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                ),10.sh,
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
                  controller: provider.password,
                  hinttext: "Password",
                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password can't be empty";
                                  } else if (value.length < 3) {
                                    return "Password must be greater than 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                ),
                10.sh,
                commonText(text: "Phone Number", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                      10.sh,
                CommonTextField(
                  controller: provider.phoneNumber,
                  hinttext: "Phone Number",
                keyboardType:TextInputType.number,
                 validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Phone Number can't be empty";
                                  } else if (value.length < 6) {
                                    return "Phone Number must be greater than 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                ),
              
                30.sh,
                CommonButton(onPressed: (){
                  if(AddUserscreenkey.currentState!.validate()){

                    provider.addUser(provider.name.text.toString(), provider.email.text.toString(), provider.password.text.toString(), provider.phoneNumber.text.toString(),context);
                    
                  }
                }, width: width(context), text: "Sign Up",color: AppColors.primaryColor,),
                20.sh,
                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        commonText(text: "Have already an account?", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sw,
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) =>  LoginScreen())); 
                          },
                          child: commonText(text: "LogIn", size: 14, color: AppColors.primaryColor, fontweight: FontWeight.w600))
                      ],),
          
              ]),
        );})
          ),
        ),
      ),
    );
  }
}