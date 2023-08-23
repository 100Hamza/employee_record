import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../database_handler/handler.dart';
import '../../../../model/add_employee.dart';
import '../../../elements/custom_text.dart';
import '../../employees_auth_activity/employees_auth_activity_view.dart';


class EmployeeRecordBody extends StatefulWidget {
  const EmployeeRecordBody({Key? key}) : super(key: key);

  @override
  State<EmployeeRecordBody> createState() => _EmployeeRecordBodyState();
}

class _EmployeeRecordBodyState extends State<EmployeeRecordBody> {

  DBHandler? dbHandler;
  String? keyword;
  late Future<List<AddEmployee>> employeesList;

  @override
  initState() {
    // at the beginning, all users are shown
    dbHandler = DBHandler();
    loadData();
    super.initState();
  }

  loadData() async
  {
    employeesList = dbHandler!.getEmployeeList('add_employee');
    print(employeesList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            // onChanged: (value) => _runFilter(value),
            onChanged: (value) {
              keyword = value;
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              hintText: "Search",
              suffixIcon: const Icon(Icons.search),
              // prefix: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: (keyword == null || keyword.toString().isEmpty) ? FutureBuilder(
              future: employeesList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the future to complete
                  return Container();
                } else if (snapshot.hasError) {
                  // If an error occurs while fetching the data
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  // If there's no data or data is null
                  return Text('No data available');
                }
                else
                  {
                    var data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: InkWell(
                          onTap: (){
                            String number = data[index].employeeNumber.toString();
                            NavigationHelper.pushRoute(context, EmployeesAuthActivityView(employeeNumber: number,));
                          },
                          child: ListTile(
                            title: CustomText(text: data[index].employeeName.toString()),
                            subtitle: CustomText(text: data[index].employeeNumber.toString()),

                          ),
                        ),
                      ),
                    );
                  }
              },) :
            FutureBuilder(
              future: dbHandler!.searchEmployees(keyword.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the future to complete
                  return Container();
                } else if (snapshot.hasError) {
                  // If an error occurs while fetching the data
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  // If there's no data or data is null
                  return Text('No data available');
                }

                else
                  {
                    var data = snapshot.data;
                    return keyword.toString().isNotEmpty
                        ?  ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: InkWell(
                          onTap: (){
                            // NavigationHelper.pushRoute(context, EmployeeAuthView());
                          },
                          child: ListTile(
                            title: CustomText(text: data[index].employeeName.toString()),
                            subtitle: CustomText(text: data[index].employeeNumber.toString()),

                          ),
                        ),
                      ),
                    )
                        : Center(
                      child: CustomText(text: 'Search Name in the Search Bar', fontSize: 18),
                    );
                  }
              },),
          )
        ],
      ),
    );
  }
}
