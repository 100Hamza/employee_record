import 'package:employee_record/presentation/view/employees_auth_activity/layout/employees_auth_activity_body.dart';
import 'package:flutter/material.dart';

import '../../../model/data_and_time.dart';

class EmployeesAuthActivityView extends StatelessWidget {
  String? employeeNumber;

  EmployeesAuthActivityView({this.employeeNumber});

  Stream<DateTime> timeStream =
  Stream<DateTime>.periodic(Duration(seconds: 1), (count) {
    return DateTime.now();
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity'), centerTitle: true,
        leading: SizedBox(
            width: 40,
            child: StreamBuilder<DateTime>(
                stream: timeStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    {
                      DateTime currentTime = snapshot.data!;
                      String formattedTime = DateTimeFormatter.currentTimeForScreens(currentTime);
                      return Center(
                        child: Text(
                          formattedTime,
                        ),
                      );
                    }
                  else
                    {
                      return Container();
                    }
                }
            )),
      ),
      body: EmployeesAuthActivityBody(employeeNumber:  employeeNumber),
    );
  }
}
