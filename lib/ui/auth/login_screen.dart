import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_cry/ui/auth/otp_screen.dart';
import 'package:first_cry/ui/auth/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/apputill.dart';
import '../../constant/color.dart';
import '../../custom/custom_button.dart';
import '../../custom/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  var verificationId;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h,),
                SizedBox(height: 20.h),
                CustomTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  controller:phoneController,
                   headingText: ' Phone Number',
                  labelText: "Phone",
                  fillColor: ColorConstants.greyColor.withOpacity(0.03),
                ),

                SizedBox(height: 20.h,),


                CustomButton(
                  onTap: (){
                    if(phoneController.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter Phone number");
                    }else{
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 3), (){

                        setState(() {
                          verifyPhoneNumber();
                          isLoading = false;
                        });
                      }
                      );
                    }
                  },
                  textColor: ColorConstants.whiteColor,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)  // Show the loader when isLoading is true
                      : const Text('Login')
                ) ,




                SizedBox(height: 20.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'New to First Cry ?  ',
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
                          },
                        text: "register",
                        style: GoogleFonts.dmSans(
                          decoration: TextDecoration.underline,
                          color: Colors.orange ,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future verifyPhoneNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;

  try{
    auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text.toString()}",
        verificationCompleted: (phonesAuthCredentials) async {},
        verificationFailed: (verificationFailed) async {
          Fluttertoast.showToast(msg: 'check number');
        },
        codeSent: (verificationId, reseningToken) async {
          verificationId=verificationId;

            await AppUtils().setToken(reseningToken.toString());
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                OtpScreen(verificationId: verificationId,)));
            Fluttertoast.showToast(msg: 'Otp Send to ${phoneController.text.toString()}');

        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  } on FirebaseAuthException catch  (e) {
    Fluttertoast.showToast(msg: e.message.toString());
  }
  catch(e){
    Fluttertoast.showToast(msg: e.toString());

  }
  }

}
