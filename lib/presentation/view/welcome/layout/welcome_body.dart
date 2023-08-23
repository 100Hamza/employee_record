import 'dart:async';

import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../model/data_and_time.dart';
import '../../home/home_view.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    // Update the time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    setState(() {
      DateTime dateTime = DateTime.now();
      currentTime = DateTimeFormatter.currentTime(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavigationHelper.pushRoute(context, HomeView());
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/bg.jpeg'), fit: BoxFit.cover)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: CustomText(text: currentTime, textColor: Colors.black , fontSize: 22,),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: CustomText(text: 'Welcome', textColor: Colors.black , fontSize: 32,),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0 , bottom: 10),
            child: CustomText(text: 'Tap on the Screen', textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
