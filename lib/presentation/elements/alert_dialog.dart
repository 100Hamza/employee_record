import 'package:employee_record/presentation/elements/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future alertDialogBox(BuildContext context,
    {required VoidCallback yesButton, noButton , required String title}) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: CustomText(text: title),

          actions: [
            TextButton(
              onPressed: yesButton,
              child: Text('Yes')
            ),
            TextButton(
                onPressed: noButton,
                child: Text('No')
            )
          ],
        );
      });
}
