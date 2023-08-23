import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../database_handler/handler.dart';
import '../../../../model/data_and_time.dart';
import '../../../../model/employee_auth_model.dart';
import '../../../elements/custom_button.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/custom_text_field.dart';
import '../../../utils/converting_image.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/toast.dart';

class EmployeeLogoutBody extends StatefulWidget {
  String? employeeNumber;
  String? employeeName;
  EmployeeLogoutBody({this.employeeName, this.employeeNumber});

  @override
  State<EmployeeLogoutBody> createState() => _EmployeeLogoutBodyState();
}

class _EmployeeLogoutBodyState extends State<EmployeeLogoutBody> {

  DBHandler? dbHandler;
  TextEditingController _employeeName = TextEditingController();
  TextEditingController _employeeNumber = TextEditingController();
  XFile? _imageFile;

  Future getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _imageFile = XFile(pickedImage.path);
      } else {
        print('No Image selected');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHandler = DBHandler();
  }

  Future<void> isUserExist(String employeeNumber, String employeeName , String date, String time) async {
    bool isExist = await dbHandler!.inUserExist(employeeNumber, employeeName);

    if (isExist) {

      String image = await ConvertImage.saveImageToFile(_imageFile!);
      print('ConvertImage ${image}');

      dbHandler!.employeeAuthInsertion(
          EmployeeAuthModel(
              employeeName: _employeeName.text,
              employeeNumber: _employeeNumber.text,
              employeeImage: image,
              employeeAuthDate: date,
              employeeAuthTime: time,
            authStatus: 'Logout'
          )
      ).then((value)async{
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.remove(_employeeNumber.text.toString());
        Navigator.pop(context);
        ToastMsg().toastMessage('See you soon...😊');
        _employeeName.clear();
        _employeeNumber.clear();


      }).onError((error, stackTrace) {
        ToastMsg().toastMessage('Error: ${error.toString()}');
      });

    } if(isExist == false) {
      ToastMsg().toastMessage('Invalid Credentials.');
    }
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    _employeeNumber.text = widget.employeeNumber!;
    _employeeName.text = widget.employeeName!;
    String formattedDate = DateTimeFormatter.formatDate(now);
    String formattedTime = DateTimeFormatter.formatTime(now);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ScreenSize().height(context, 0.04),
          ),
          Center(child: CustomText(text: 'Logout', fontSize: 28)),
          SizedBox(
            height: ScreenSize().height(context, 0.04),
          ),
          CustomTextField(fieldName: 'Employee Name',controller:  _employeeName),
          CustomTextField(fieldName: 'Employee Number', controller: _employeeNumber,),
          SizedBox(
            height: ScreenSize().height(context, 0.04),
          ),
          InkWell(
            onTap: () {
              getImage(ImageSource.camera);
            },
            child: _imageFile != null
                ? Container(
              alignment: Alignment.center,
              height: ScreenSize().height(context, 0.3),
              width: ScreenSize().width(context, 0.6),
              decoration: BoxDecoration(
                image: _imageFile == null
                    ? null
                    : DecorationImage(
                  image: FileImage(File(_imageFile!.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
                :  Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: ScreenSize().height(context, 0.3),
              width: ScreenSize().width(context, 0.7),
              child: Icon(Icons.image_outlined , size: 70, color: Colors.white,),
            ),
          ),

          SizedBox(
            height: ScreenSize().height(context, 0.04),
          ),
          CustomButton(buttonTitle: 'Logout', color: Colors.blue,
            onPressed: () async {
              if(_imageFile == null)
              {
                ToastMsg().toastMessage('Tap on image Button to Capture your image');
              }
              if (_employeeName.text.isEmpty || _employeeNumber.text.isEmpty)
              {
                ToastMsg().toastMessage('Employee Name & Employee Number must be fill😢');
              }
              else
              {
                isUserExist(_employeeNumber.text, _employeeName.text , formattedDate, formattedTime);

              }
            },)
        ],
      ),
    );
  }
}
