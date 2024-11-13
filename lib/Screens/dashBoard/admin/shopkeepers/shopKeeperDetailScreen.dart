import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/shopKeeperProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/shopkeepers/allShopKeepers.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class shopKeeperDetailScreen extends StatefulWidget {
  const shopKeeperDetailScreen({super.key});

  @override
  State<shopKeeperDetailScreen> createState() => _shopKeeperDetailScreenState();
}

class _shopKeeperDetailScreenState extends State<shopKeeperDetailScreen> {
      GlobalKey<FormState> addShopKeeperKey=GlobalKey();

@override
  void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
    var shopKeeperP = Provider.of<shopKeeperProvider>(context, listen: false);
    shopKeeperP.branchesList=[];
    shopKeeperP.getAllBranches(context);
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: addShopKeeperKey,
          child: Consumer<shopKeeperProvider>(builder: (context,provider,child){
                  return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sh,
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => allShopKeepers()),
          );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                commonText(text: provider.getspecificChk? "Retailer Details":"Update Retailer", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.shopKeeperName,
                  isEditable:provider.getspecificChk?false:true,
                  hinttext: AppConstants.getSpecShopKeeperModel!.name.toString(),
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
                  controller: provider.shopKeeperEmail,
                  hinttext: AppConstants.getSpecShopKeeperModel!.email.toString(),
                isEditable:provider.getspecificChk?false:true,
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
                
                commonText(text: "Phone Number", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.shopKeeperPhoneNumber,
                  hinttext: AppConstants.getSpecShopKeeperModel!.phoneNumber.toString(),
                isEditable: provider.getspecificChk?false:true,
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
                provider.getspecificChk? CommonTextField(
                  controller: provider.shopKeeperBranch,
                  hinttext: provider.specificBranch!.name.toString(),
                isEditable: provider.getspecificChk?false:true,
                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone Number can't be empty";
                                    } else if (value.length < 6) {
                                      return "Phone Number must be greater than 6 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                ):
                Column(
                  children: [
                  provider.branchLoadChk?Center(
                    child: CircularProgressIndicator(),
                  ): CommonDropDown(
                    width: width(context), 
                    selectedText: provider.branchSelectedValue.toString(),
                    listItem:provider.branchesList, 
                    onchanged: (val){
                        provider.changeBranchNameValue(val);
                    }),
                    30.sh,
              provider.shopKeeperLoadChk?Center(child: CircularProgressIndicator()): CommonButton(onPressed: (){
                if(addShopKeeperKey.currentState!.validate()){
                provider.updateSpecificShopKeper(
                        AppConstants.getSpecShopKeeperModel!.id.toString(),
                        provider.shopKeeperName.text.toString(),
                        provider.shopKeeperEmail.text.toString(),
                        provider.shopKeeperPass.text.toString(),
                        provider.shopKeeperPhoneNumber.text.toString(),
                        provider.branchSelectedValueId.toString(),
                        context
                    );
                  }
                }, width: width(context), text: "Update",color: AppColors.primaryColor,),10.sh
                  ],
                )
              
          ]);})
        ),
      ),
    ),
    );
  }
}