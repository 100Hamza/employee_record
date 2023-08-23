import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../model/data_and_time.dart';
import 'layout/admin_auth_body.dart';

class AdminAuthView extends StatelessWidget {
  AdminAuthView({Key? key}) : super(key: key);


  Stream<DateTime> timeStream =
  Stream<DateTime>.periodic(Duration(seconds: 1), (count) {
    return DateTime.now();
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
          title: const Text('Admin') , centerTitle: true,
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
      ),
      body: const AdminAuthBody(),
    );;
  }
}
