import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? buttonTitle;
  Color? color;

  CustomButton({this.buttonTitle, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Material(
          elevation: 10,
          borderOnForeground: true,
          shadowColor: Color(0xFF1350E0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
            ),
              child: CustomText(text: buttonTitle.toString(), textColor: Colors.white, textAlign: TextAlign.center, fontSize: 17, fontWeight: FontWeight.w500,)),
        ),
      ),
    );
  }
}
