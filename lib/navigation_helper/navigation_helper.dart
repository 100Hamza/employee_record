
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper{
  static pushRoute(BuildContext context, Widget targetedClass)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => targetedClass,));
  }
}