import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_cry/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant/color.dart';
import '../../custom/custom_button.dart';
import '../../custom/custom_textfield.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController PasswordController=TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                CustomTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: firstNameController,
                   headingText: "Full Name",
                  labelText: "Full Name",
                  fillColor: ColorConstants.greyColor.withOpacity(0.03),
                ),
                CustomTextField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  headingText: "Email",

                  controller: emailController,
                  labelText: "email",
                  fillColor: ColorConstants.greyColor.withOpacity(0.03),
                ),
                CustomTextField(
                  maxLines: 1,maxLength: 15,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  headingText: "Phone Number",

                  labelText: "enterPhoneNumber",
                  fillColor: ColorConstants.greyColor.withOpacity(0.03),
                ),
                CustomTextField(
                  maxLines: 1,maxLength: 15,
                  controller: PasswordController,
                  labelText: "Password",
                  headingText: "Password",

                  fillColor: ColorConstants.greyColor.withOpacity(0.03),
                ),


                SizedBox(height: 20.h),

                CustomButton(
                    onTap: (){
                      if( firstNameController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter FirstName");
                      }
                      else if( emailController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter email");
                      } else if(!EmailValidator.validate(emailController.text)) {
                        Fluttertoast.showToast(msg: "Please Enter Valid Email Address",);
                      }
                      else if( phoneController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter Phone");
                      } else if(PasswordController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter Password");
                      }else{
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 3), (){

                          setState(() {
                            create();
                            isLoading = false;
                          });
                        }
                        );
                      }
                    },
                    textColor: ColorConstants.whiteColor,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white,)  // Show the loader when isLoading is true
                        : const Text('Register')
                ) ,
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future create() async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),password:  PasswordController.text.toString() ).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        Fluttertoast.showToast(msg: 'register  successfully');
      });
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");
      }
    }  catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
