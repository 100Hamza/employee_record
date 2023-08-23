
import 'dart:async';

import 'package:employee_record/database_handler/handler.dart';
import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:employee_record/presentation/utils/toast.dart';
import 'package:employee_record/presentation/view/admin_auth/admin_auth_view.dart';
import 'package:employee_record/presentation/view/employees_record/employees_record_view.dart';
import 'package:employee_record/presentation/view/home/layout/home_body.dart';
import 'package:employee_record/presentation/view/home/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/data_and_time.dart';



class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  Stream<DateTime> timeStream =
  Stream<DateTime>.periodic(Duration(seconds: 1), (count) {
    return DateTime.now();
  });

  @override
  Widget build(BuildContext context) {
    DBHandler dbHandler = DBHandler(); // Create an instance of DBHandler

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
            width: 40,
            child: StreamBuilder<DateTime>(
              stream: timeStream,
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                  {
                    return Container();
                  }

                else
                  {
                    DateTime currentTime = snapshot.data!;
                    String formattedTime = DateTimeFormatter.currentTimeForScreens(currentTime);
                    return Center(
                      child: Text(
                        formattedTime,
                      ),
                    );
                  }
              }
            )),
          actions: [
            InkWell(
                onTap: () async  {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                   bool? df = sp.getBool('admin_auth');
                  print('Out Value: $df');
                  if(df == true)
                    {
                      print('True insideValue: $df');
                      NavigationHelper.pushRoute(context, EmployeeRecordView());
                    }
                  else if (df == false)
                    {
                      print('False Inside Value: $df');
                      NavigationHelper.pushRoute(context, AdminAuthView());
                    }
                  else
                    {
                      // The value is null, handle it here
                      // For example, you might want to navigate to the AdminAuthView by default
                      NavigationHelper.pushRoute(context, AdminAuthView());
                    }
                 // await dbHandler.clearEmployeeTable();
                },
                child: const Icon(Icons.login)),
            Container(width: 20,)
          ],
          title: const Text('Welcome') , centerTitle: true),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return draggableBottomSheer();
          },
        );
      } ,child: Icon(Icons.add)),
    );
  }
}
