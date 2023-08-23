import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:employee_record/presentation/elements/alert_dialog.dart';
import 'package:employee_record/presentation/view/employees_record/layout/employee_record_body.dart';
import 'package:employee_record/presentation/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/data_and_time.dart';
import '../../elements/custom_text.dart';

class EmployeeRecordView extends StatelessWidget {
   EmployeeRecordView({Key? key}) : super(key: key);

  Stream<DateTime> timeStream =
  Stream<DateTime>.periodic(Duration(seconds: 1), (count) {
    return DateTime.now();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record'), centerTitle: true ,
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
            onTap: () {
              alertDialogBox(context,title: 'Do you want to Logout?', yesButton: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                await sp.setBool('admin_auth' , false);
                NavigationHelper.pushRoute(context, HomeView());
              } , noButton: (){
                Navigator.pop(context);
              });
            },
            child: Icon(Icons.logout_rounded)),
        Container(width: 20,)
      ]),
      body: EmployeeRecordBody(),

    );
  }
}
