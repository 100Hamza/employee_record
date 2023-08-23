import 'package:employee_record/database_handler/handler.dart';
import 'package:employee_record/model/add_employee.dart';
import 'package:employee_record/model/employee_data.dart';
import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:employee_record/presentation/utils/toast.dart';
import 'package:employee_record/presentation/view/employee%20auth/employee_auth_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {



  DBHandler? dbHandler;
  String? keyword;
  late Future<List<AddEmployee>> employeeList;

  // This list holds the data for the list view
  List<employee_record> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = [];
    super.initState();

    dbHandler = DBHandler();
  }

  // loadEmployeeData() async
  // {
  //   employeeList = dbHandler!.getEmployeeList();
  // }


  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<employee_record> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = [];
    } else {
      results = employee_recordList
          .where((user) =>
          user.commentUserName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
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
            child: FutureBuilder(
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
                    print('Keyword: $keyword');
                    return (keyword == null || keyword.toString().isEmpty)
                        ?   Center(
                      child: CustomText(text: 'Search Name in the Search Bar.', fontSize: 18),
                    )
                        :ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: InkWell(
                          onTap: () async{
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            String? currentEmployeeAuth = sp.getString(data[index].employeeNumber.toString());
                            String? currentEmployeeName = sp.getString(data[index].employeeName.toString());

                            if(currentEmployeeAuth == data[index].employeeNumber.toString())
                            {
                              return NavigationHelper.pushRoute(context, EmployeeAuthView(employeeNumber: data[index].employeeNumber.toString(),employeeName: data[index].employeeName.toString(),));
                            }
                            if(currentEmployeeAuth == null)
                            {
                              return NavigationHelper.pushRoute(context, EmployeeAuthView(employeeNumber: data[index].employeeNumber.toString(),employeeName: data[index].employeeName.toString()));
                            }
                          },
                          child: ListTile(
                            title: CustomText(text: data[index].employeeName.toString()),
                            subtitle: CustomText(text: data[index].employeeNumber.toString()),

                          ),
                        ),
                      ),
                    );
                  }
            },),
          )
        ],
      ),
    );
  }
}
