import 'package:flutter/material.dart';
import 'package:fyplms/Utils/Colors.dart';

class CommonDropDown extends StatelessWidget {
  String selectedText = '';
  List<String> listItem = [];
  var onchanged;
  double width;
  Color color;

  CommonDropDown({
    super.key,
    required this.width,
    required this.selectedText,
    required this.listItem,
    this.color=Colors.white,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // width: MediaQuery.of(context).size.width,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.black54,
        // ),
        color:color
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedText,
        underline:const Text(""),
        items: listItem.map((String value) {
          return DropdownMenuItem<String>(
            
            value: value,
            child: Container(
              width: width,
              // decoration: BoxDecoration(
              // border: Border(
              //         bottom: BorderSide(
              //       color: AppColors.whiteColor,
              //       width: 1.5,
              //     )),),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                 ),
              ),
            ),
          );
        }).toList(),
        onChanged: onchanged,
      ),
      
    );
  }
}
