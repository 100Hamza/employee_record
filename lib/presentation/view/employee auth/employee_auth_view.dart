import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layout/employee_login_body.dart';
import 'layout/employee_logout_body.dart';

class EmployeeAuthView extends StatelessWidget {
  String? employeeNumber;
  String? employeeName;
   EmployeeAuthView({this.employeeNumber , this.employeeName});



  Future<String?> getEmployeeNumber(String employeesNumber) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? employeeNumber = sp.getString(employeesNumber);
    return employeeNumber;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: const Text('Employee') , centerTitle: true),
      body: FutureBuilder<String?>(
        future: getEmployeeNumber(employeeNumber!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            // If an error occurs while checking the status
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data != null) {
            // If the employee number is stored (logged in)
            return EmployeeLogoutBody(employeeName: employeeName, employeeNumber: employeeNumber,); // Replace with your widget for logged-in users
          } else {
            // If the employee number is not stored (not logged in)
            return EmployeeLoginBody(employeeName: employeeName, employeeNumber: employeeNumber,); // Replace with your login widget
          }
      },),
    );
  }
}
