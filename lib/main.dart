import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/screens/splash_screen.dart';

void main(){
  runApp(const CraftBay());
}

class CraftBay extends StatelessWidget {
  const CraftBay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
