import 'dart:async';

import 'package:first_cry/constant/apputill.dart';
import 'package:first_cry/constant/color.dart';
import 'package:first_cry/ui/auth/home_screen.dart';
import 'package:first_cry/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  startTimer()async{
    var duration=Duration(seconds: 5);
    return Timer(duration, navigationServices);
  }
  void navigationServices()async{
    AppUtils().getToken().then((value) {
      if(value.isNotEmpty){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);

      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:  Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/fc-logo-s.jpg",height: 200,width: 200,),
            ],
          ),
        ),

      ),
    );
  }
}
