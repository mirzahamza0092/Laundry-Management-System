import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/machineProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/productProvider.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> addProductsKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "Laundry Manager",
          ), 
    ),
    body: SingleChildScrollView(
      child:  Consumer<ProductsProvider>(builder: (context,provider,child){
                return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key:addProductsKey ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sh,
            Row(
              children: [
                InkWell(
                  onTap: (){
                    provider.clearInputData();
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => RetailerDashboard()),
          );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                commonText(text: "Add Product  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.productName,
                  hinttext: "Name",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Name can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Quantity ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.productQuantity,
                  keyboardType: TextInputType.number,
                  hinttext: "Quantity",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Quantity can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Price ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller:provider.productPrice,
                  hinttext: "Price",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Price can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Type", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonDropDown(width: width(context), selectedText: provider.selectedMachineType.toString(), listItem:provider.machinetypeList, onchanged: (val){
                        provider.typeChange(val);
                                      }),
                // commonText(text: "Image ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                
                // Row(
                //   children: [
                //     Container(
                //       width: width(context)/1.4,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         color: AppColors.whiteColor
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 24,top: 15,bottom: 15),
                //         child: commonText(text: provider.imageName==null?"Choose Image":provider.imageName.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: (){
                //         provider.pickImage();
                //       },
                //       child: Image(image:AssetImage(ImagePath.imagePickerIcon),width: 75,height: 75,))
                //   ],
                // ),
                30.sh,
            provider.productLoadChk?
            Center(child: CircularProgressIndicator()):
            CommonButton(onPressed: (){
          if(addProductsKey.currentState!.validate()){
              provider.addProduct(
              provider.productName.text.toString(),
              provider.productPrice.text.toString(),
              provider.productQuantity.text.toString(), context);
                }
                }, width: width(context), text: "Submit",color: AppColors.primaryColor,)
          ]),
        ),
      );})
    ),
    );
  }
}