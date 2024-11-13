import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/AuthProvider/loginProvider.dart';
import 'package:fyplms/Screens/Auth/AddUserScreen.dart';
import 'package:fyplms/Screens/Auth/SetPasswordScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
GlobalKey<FormState> loginscreenkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<loginProvider>(builder: (context,provider,child){
        return SafeArea(
          child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0),
              child: Form(
                key: loginscreenkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: commonText(text: "LaundroMATE",size: 28,color: AppColors.blackColor,fontweight: FontWeight.w500)),10.sh,
                    Center(child: Image(image:AssetImage(ImagePath.appLogo),width: 150,height: 150,)),
                    Center(child: commonText(text: "Login",size: 20,color: AppColors.blackColor,fontweight: FontWeight.w500)),

                    40.sh,
                    commonText(text: "Email", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                    10.sh,
                    CommonTextField(controller: provider.username,hinttext: "Email",
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
                      controller: provider.password,hinttext: "Password",suffixicon: GestureDetector(
                                  onTap: () =>
                                    provider.showHidePassWord(),
                                  child: provider.chkPassword
                                      ? const Icon(Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                                      obsecure: provider.chkPassword,
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
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => SetPassword()));
                                          },
                                          child: commonText(text: "Forget Password ?", size: 12, color: AppColors.primaryColor, fontweight: FontWeight.w500))),
                                      35.sh,
                                      provider.resChk?Center(child: CircularProgressIndicator()):
                  Column(
                    children: [
                      CommonButton(onPressed: (){
                      if (loginscreenkey.currentState!.validate()) {
                          provider.hitLogin(provider.username.text.toString(), provider.password.text.toString(), context);
                      }
                      }, 
                      
                      width: width(context), text: "Sign In",
                      
                      color: AppColors.primaryColor,
                      ),20.sh,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        commonText(text: "Don't have an account?", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sw,
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => AddUserScreen())); 
                          },
                          child: commonText(text: "Sign Up", size: 14, color: AppColors.primaryColor, fontweight: FontWeight.w600))
                      ],),
                    ],
                  ),
                
                  
                  ],
                ),
              ),
            ),
          )
                ),
        );
      }),);
      
  }
}