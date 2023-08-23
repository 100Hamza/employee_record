import 'package:employee_record/database_handler/handler.dart';
import 'package:employee_record/model/employee_auth_model.dart';
import 'package:employee_record/presentation/elements/custom_widget_of_employee_activity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../elements/custom_text.dart';
import '../../../utils/toast.dart';

class EmployeesAuthActivityBody extends StatefulWidget {
  String? employeeNumber;

  EmployeesAuthActivityBody({this.employeeNumber});

  @override
  State<EmployeesAuthActivityBody> createState() =>
      _EmployeesAuthActivityBodyState();
}

class _EmployeesAuthActivityBodyState extends State<EmployeesAuthActivityBody> {
  DBHandler? dbHandler;
  bool isNumberExist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler = DBHandler();
    loadData();
    checkEmployeeNumber(widget.employeeNumber.toString());
  }

  String? keyword;
  late Future<List<EmployeeAuthModel>> employeesAuthRecordList;

  loadData() async {
    employeesAuthRecordList =
        dbHandler!.getEmployeeAuthRecord('employee_authentication');
  }

  Future<void> checkEmployeeNumber(String employeeNumber) async {
    bool isExist = await dbHandler!
        .isEmployeeNumberExist(employeeNumber, 'employee_authentication');
    if (isExist) {
      setState(() {
        isNumberExist = true;
      });
    } else {
      setState(() {
        isNumberExist = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isNumberExist
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(text: 'Employee History', fontSize: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder<List<EmployeeAuthModel>>(
                      future: employeesAuthRecordList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While waiting for the future to complete
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If an error occurs while fetching the data
                          print('Error: ${snapshot.error}');
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          // If there's no data or data is null
                          return Text('No data available');
                        } else {
                          var data = snapshot.data;

                          // Filter the data based on the provided employeeNumber
                          var filteredData = data!.where((item) =>
                          item.employeeNumber.toString() == widget.employeeNumber.toString()).toList();


                          filteredData.sort((a, b) {
                            if (a.employeeAuthDate == null || b.employeeAuthDate == null) {
                              return 0; // If any date is null, treat them as equal
                            }

                            var dateComparison = b.employeeAuthDate!.compareTo(a.employeeAuthDate!);

                            if (dateComparison == 0) {
                              // If the dates are the same, compare the times
                              if (a.employeeAuthTime == null || b.employeeAuthTime == null) {
                                return 0; // If any time is null, treat them as equal
                              }
                              return b.employeeAuthTime!.compareTo(a.employeeAuthTime!);
                            }

                            return dateComparison;
                          });

                          return ListView.builder(
                            itemCount: filteredData.length,
                            itemBuilder: (context, index) {
                              return EmployeeInfoCard(
                                imagePath: filteredData[index].employeeImage.toString(),
                                name: filteredData[index].employeeName.toString(),
                                number: filteredData[index].employeeNumber.toString(),
                                date: filteredData[index].employeeAuthDate.toString(),
                                time: filteredData[index].employeeAuthTime.toString(),
                                status: filteredData[index].authStatus.toString(),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: Text('Have not started activity.'),
          );
  }
}
