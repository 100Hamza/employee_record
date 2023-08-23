
import 'package:employee_record/database_handler/handler.dart';
import 'package:employee_record/model/add_employee.dart';
import 'package:employee_record/presentation/elements/custom_button.dart';
import 'package:employee_record/presentation/elements/custom_text_field.dart';
import 'package:employee_record/presentation/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../elements/custom_text.dart';
import '../../../utils/screen_size.dart';

class draggableBottomSheer extends StatefulWidget {
  const draggableBottomSheer({Key? key}) : super(key: key);

  @override
  State<draggableBottomSheer> createState() => _draggableBottomSheerState();
}

class _draggableBottomSheerState extends State<draggableBottomSheer> {

  DBHandler? dbHandler;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler = DBHandler();
  }

  Future<void> checkEmployeeNumber(String employeeNumber) async {
    bool isExist = await dbHandler!.isEmployeeNumberExist(employeeNumber, 'add_employee');
    print('Outside ALready added $isExist');
    print('Number value added $employeeNumber');
    if (isExist) {
      print('IN IsExist ALready added $isExist');
      ToastMsg().toastMessage('Employee is Already Exist');
    } else {
      print('IN Else ALready added $isExist');
      print('Employee number is unique.');
      dbHandler!.insert(
          AddEmployee(
              employeeName: _name.text,
              employeeNumber: _number.text
          )
      ).then((value){
        ToastMsg().toastMessage('Employee is Added Successfully');
        _name.clear();
        _number.clear();
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        ToastMsg().toastMessage('Error: ${error.toString()}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      minChildSize: 0.1,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: ScreenSize().height(context, 0.006),
                    width: ScreenSize().width(context, 0.16),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: ScreenSize().height(context, 0.01),
                ),
                Center(child: CustomText(text: 'Add New Employee', fontSize: 18)),
                CustomTextField(fieldName: 'Employee Name', controller: _name),
                CustomTextField(fieldName: 'Employee Number', controller: _number,),
                SizedBox(
                  height: ScreenSize().height(context, 0.025),
                ),
                CustomButton(buttonTitle: 'Add Employee', color: Colors.blue,  onPressed: (){
                  print('Name ${_name.text}');
                  print('Name ${_number.text}');

                  if(_name.text.isEmpty || _number.text.isEmpty)
                    {
                      ToastMsg().toastMessage('Both fields must be fill.');
                    }
                  else
                    {
                      checkEmployeeNumber(_number.text);
                    }
                },)
              ],
            )
        );
      },
    );
  }
}
