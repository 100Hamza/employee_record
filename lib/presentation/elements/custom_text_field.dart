import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/screen_size.dart';
import 'custom_text.dart';


class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  int maxLines;
  // FontWeight? fontWeight;
  bool isPass , isTitle , isHintText , isFilled;
  int? maxlength;
  String? fieldName;
  TextInputType? textInputType;
  TextAlign textAlign;
  double height;
  String hintText;



  CustomTextField(
      {
        this.textAlign = TextAlign.start,
        this.maxlength,
        this.controller,
        this.maxLines = 1,
        // this.fontWeight,
        this.textInputType,
        this.fieldName,
        this.isPass = false,
        this.isTitle = true,
        this.isHintText = false,
        this.isFilled = true,
        this.height = 0.05,
        this.hintText = 'What is Happening?'
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: fieldName.toString(), fontSize: 14, fontWeight: FontWeight.w300, textColor: Colors.black, fontFamily: 'Roboto',) ,
          SizedBox(height: 5,),
          Container(
            height: ScreenSize().height(context,height),
            child: TextField(
              textAlign: textAlign,
              obscureText: isPass,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: textInputType,
              maxLength: maxlength,
              controller: controller,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                // fontWeight: fontWeight,
              ),
              maxLines: maxLines,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), // Set the border radius
                    borderSide: BorderSide(width: 2, color: Colors.grey), // Remove the border
                  ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                  BorderSide(width: 2, color: Colors.green),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
