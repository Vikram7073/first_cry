import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';
import '../constant/font_style.dart';

class CustomTextField extends StatelessWidget {
  double? height;
  TextInputType keyboardType;
  String? labelText;
  String? headingText;
  Color? fillColor;
  Color? colors;
  Color? color;
  bool? enable;
  Widget? prefix;
  Widget? suffix;
  Widget? prefixIcon;
  int? maxLines;
  int? maxLength;
  bool? obscureText;
  void Function()? onTap;
  TextCapitalization?  textCapitalization;
  List<TextInputFormatter>?  inputFormatters;
  String? Function(String?)? validator;
  String? Function(String?)? onSubmit;
  TextEditingController controller = TextEditingController();
  void Function(String)? onSaved;
  void Function(String)? onChanged;
  CustomTextField({super.key,
    this.obscureText,
    this.textCapitalization,
    this.validator,
    this.prefix,
    this.suffix,
    this.enable ,
    this.onTap,
    this.inputFormatters,
    this.fillColor,
    required this.controller,
    this.labelText,
    this.maxLines,
    this.onSubmit,
    this.prefixIcon,
    this.colors,
    this.color,
    this.onSaved,
    this.headingText,
    this.onChanged,
    this.keyboardType= TextInputType.multiline, this.maxLength,this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 5.w,),
            Text( headingText??"",style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              color: color,
            )),
          ],
        ),
        SizedBox(
          height: height,
        ),
        TextFormField(

          textInputAction: TextInputAction.newline,
          inputFormatters: inputFormatters,
          maxLength: maxLength??100,
          onSaved: onSubmit??(val){},
          cursorColor: ColorConstants.themeColor,
          cursorWidth: 1,
          validator: validator??(val){},
          onChanged: onChanged,
          obscureText: obscureText??false,
          maxLines: maxLines,
          enabled: enable,
          keyboardType: keyboardType,
          controller: controller,
          textCapitalization: textCapitalization??TextCapitalization.none,
          //  onSaved: onSaved,
          style: const TextStyle(
              color:ColorConstants.blackColor
          ),
          decoration: InputDecoration(
            counterText: "",
            // alignLabelWithHint: true,
            prefix: prefix,
            suffixIcon: suffix,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            hintText: labelText,
            labelStyle: AppStyles.greyBlackColor12Text,
            hintStyle: GoogleFonts.dmSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: colors ?? ColorConstants.greyColor,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(color: ColorConstants.whiteColor.withOpacity(0.2)),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(color: ColorConstants.whiteColor.withOpacity(0.2)),
            ),
            errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(color: ColorConstants.whiteColor.withOpacity(0.2)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(color: ColorConstants.whiteColor.withOpacity(0.2)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}