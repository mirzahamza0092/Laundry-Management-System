import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long-running task such as initializing your app
    _mockInitialization().then((value) {
      // After the long-running task, navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  Future _mockInitialization() async {
    await Future.delayed(Duration(seconds: 4)); // Simulate a 3-second delay
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color.fromARGB(255, 85, 144, 253),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image:AssetImage(ImagePath.appLogo),width: 150,height: 150,),
            commonText(text: "LaundroMATE...",size: 24,color: AppColors.whiteColor,fontweight: FontWeight.w500)
          
          ],
        )
      ),
    );
    
  }
}