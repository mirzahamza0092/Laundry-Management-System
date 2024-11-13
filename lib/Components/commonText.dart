import 'package:flutter/material.dart';

Widget commonText({
required String text,
required double size,
required Color color,
required var fontweight,

}){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontWeight: fontweight ),);
}