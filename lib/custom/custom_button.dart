
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';


class CustomButton extends StatelessWidget
{
  double? buttonWidth = 0;
  void Function() onTap;
  //String? text;
  Widget? child;
  double? buttonHeight;
  double? textSize;
  Color? buttonColor;
  Color? textColor;
  double? horizontal;
  CustomButton({ Key? key,this.textSize = 18,this.child, this.horizontal, this.buttonHeight = 50,  this.buttonWidth, this.textColor, required this.onTap,   this.buttonColor = ColorConstants.blackColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool pad;
    return InkWell(
      highlightColor:Colors.transparent ,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          height: buttonHeight,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(

            // border: Border.all(color:ColorConstants.blueLightColor,width: 2),
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: child,
        ),
      ),

    );
  }
}