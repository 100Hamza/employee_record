import 'package:employee_record/navigation_helper/navigation_helper.dart';
import 'package:employee_record/presentation/view/employees_record/employees_record_view.dart';
import 'package:employee_record/presentation/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../elements/custom_button.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/custom_text_field.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/toast.dart';

class AdminAuthBody extends StatefulWidget {
  const AdminAuthBody({Key? key}) : super(key: key);

  @override
  State<AdminAuthBody> createState() => _AdminAuthBodyState();
}
TextEditingController _name = TextEditingController();
TextEditingController _number = TextEditingController();
class _AdminAuthBodyState extends State<AdminAuthBody> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: ScreenSize().height(context, 0.04),
        ),
        Center(child: CustomText(text: 'Login', fontSize: 18)),
        CustomTextField(fieldName: 'Username', controller: _name),
        CustomTextField(fieldName: 'Password', controller: _number,),
        SizedBox(
          height: ScreenSize().height(context, 0.04),
        ),


        SizedBox(
          height: ScreenSize().height(context, 0.04),
        ),
        CustomButton(buttonTitle: 'Login', color: Colors.blue,
          onPressed: () async{

            if(_name.text.isEmpty || _number.text.isEmpty)
            {
              ToastMsg().toastMessage('Please🙏 Fill the Name and Number Fields');
            }
            else
            {
              if(_name.text == 'FTAC' && _number.text == '2348078590940')
              {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool('admin_auth', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return EmployeeRecordView();
                },));
                _name.clear();
                _number.clear();
              }
              else
              {
                ToastMsg().toastMessage('Invalid Credentials');
              }
            }

          },)
      ],
    );
  }
}
