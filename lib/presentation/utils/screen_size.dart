import 'package:flutter/material.dart';

class ScreenSize
{
  double height(BuildContext context,  double height)
  {
    return MediaQuery.of(context).size.height * height;
  }
  double width(BuildContext context,  double width)
  {
   return  MediaQuery.of(context).size.width * width;
  }
}