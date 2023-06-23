import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_cry/ui/auth/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constant/color.dart';
import '../../custom/custom_button.dart';
class OtpScreen extends StatefulWidget {
  var verificationId;
  var number;
   OtpScreen({Key? key,this.verificationId,this.number}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pin = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                Text(' OTP', style: GoogleFonts.dmSans(
                  color: ColorConstants.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                ),),
                SizedBox(height: 60.h),
                otp(pin),
                SizedBox(height: 20.h),


                // CustomButton(
                //   onTap: () {
                //     if(pin.text.isEmpty){
                //       Fluttertoast.showToast(msg: 'fill otp');
                //     }else{
                //       PhoneAuthCredential credential= PhoneAuthProvider.credential(
                //           verificationId: widget.verificationId, smsCode: pin.text.toString());
                //       auth.signInWithCredential(credential).then((value){
                //         Fluttertoast.showToast(msg: 'Login SuccessFull');
                //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                //             builder: (context) =>  HomeScreen()),(route) => false,);
                //       }).onError((error, stackTrace) {
                //         Fluttertoast.showToast(msg: "invalid otp");
                //       });
                //     }
                //   },
                //   textColor: ColorConstants.whiteColor,
                //   child: Text("Verify"),
                //   buttonHeight: 45.h,
                //   buttonColor: ColorConstants.themeColor,
                // ),

                CustomButton(
                    onTap: (){
                      if(pin.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Fill Otp");
                      }else{
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 3), (){

                          setState(() {
                            PhoneAuthCredential credential= PhoneAuthProvider.credential(
                                verificationId: widget.verificationId, smsCode: pin.text.toString());
                            auth.signInWithCredential(credential).then((value){
                              Fluttertoast.showToast(msg: 'Login SuccessFull');
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (context) =>  HomeScreen()),(route) => false,);
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(msg: "invalid otp");
                            });
                            isLoading = false;
                          });
                        }
                        );
                      }
                    },
                    textColor: ColorConstants.whiteColor,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white,)  // Show the loader when isLoading is true
                        : const Text('Verify')
                ) ,
                SizedBox(height: 20.h),

              ],
            ),
          ),
        ),
      ),
    );
  }

  otp(TextEditingController pin) {
    return Container(
      height: 60.h,
      width: double.infinity,
      color: Colors.transparent,
      child: PinCodeTextField(
        autoFocus: true,
        controller: pin,
        appContext: context,
        length: 6,
        enablePinAutofill: true,
        enableActiveFill: true,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        animationType: AnimationType.fade,
        textStyle: const TextStyle(color: ColorConstants.blackDarkColor),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 1,
          borderRadius: BorderRadius.circular(5.r),
          fieldHeight: 50.h,
          fieldWidth: 40.w,
          // activeFillColor: Colors.orange,
          activeFillColor: ColorConstants.greyColor.withOpacity(0.03),
          selectedColor: ColorConstants.greyColor.withOpacity(0.03),
          activeColor: ColorConstants.greyColor.withOpacity(0.03),
          // inactiveFillColor: Colors.white,
          // selectedFillColor: Colors.white,
          selectedFillColor: ColorConstants.greyColor.withOpacity(0.03),
          inactiveFillColor: ColorConstants.greyColor.withOpacity(0.03),
          inactiveColor: ColorConstants.greyColor.withOpacity(0.03),
          disabledColor: ColorConstants.greyColor.withOpacity(0.03),
        ),
        cursorColor: ColorConstants.blueLightColor,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        // enableActiveFill: true,
        //  errorAnimationController: errorController,
        //controller: otpController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          if (kDebugMode) {
            print("Completed $v");
          }
        },
        onChanged: (String value) {

        },
      ),
    );
  }

}
