import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/shopKeeperProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class addShopKeeperScreen extends StatefulWidget {
  const addShopKeeperScreen({super.key});

  @override
  State<addShopKeeperScreen> createState() => _addShopKeeperScreenState();
}

class _addShopKeeperScreenState extends State<addShopKeeperScreen> {
      GlobalKey<FormState> addShopKeeperKey=GlobalKey();

 @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var branchP = Provider.of<branchesProvider>(context, listen: false);
    branchP.branchesList=[];
    branchP.getAllBranches(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "Admin",
          ), 
    ),
    body: SingleChildScrollView(
      child: Consumer<shopKeeperProvider>(builder: (context,shopKeeperP,child){
              return  Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Form(
                  key: addShopKeeperKey,
                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.sh,
                            Row(
                              children: [
                                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => dashBoardScreen()),
                          );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                                commonText(text: "Add Retailer", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                              
                              ],
                            ),
                            20.sh,
                                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                                CommonTextField(hinttext: "Name",
                                controller: shopKeeperP.shopKeeperName,
                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Name can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                10.sh,
                                commonText(text: "Email", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                                CommonTextField(
                  controller: shopKeeperP.shopKeeperEmail,
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
                  controller: shopKeeperP.shopKeeperPass,
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
                                commonText(text: "Phone Number", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                                CommonTextField(
                                  keyboardType: TextInputType.number,
                                  controller: shopKeeperP.shopKeeperPhoneNumber,
                                  hinttext: "Phone Number",
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
                                10.sh,
                                commonText(text: "Branch", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                              Consumer<branchesProvider>(builder: (context,provider,child){
                                return provider.branchLoadChk?Center(
                    child: CircularProgressIndicator(),
                  ):Column(
                    children: [
                      CommonDropDown(width: width(context), selectedText: provider.branchSelectedValue.toString(), listItem:provider.branchesList, onchanged: (val){
                        provider.changeBranchNameValue(val);
                                      }),
                                30.sh,
                              shopKeeperP.shopKeeperLoadChk?
                              Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),):
                                CommonButton(onPressed: (){
                                if(addShopKeeperKey.currentState!.validate()){
                    shopKeeperP.addshopKeeper(shopKeeperP.shopKeeperName.text.toString(), shopKeeperP.shopKeeperEmail.text.toString(), shopKeeperP.shopKeeperPass.text.toString(), shopKeeperP.shopKeeperPhoneNumber.text.toString(), provider.branchSelectedValueId.toString(), context);
                  }
                                }, width: width(context), text: "Submit",color: AppColors.primaryColor,),10.sh
                    ],
                  );}),
                              
                          ]),
                ),
              );}),
    ),
    );
  }
}