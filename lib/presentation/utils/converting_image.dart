
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ConvertImage {
  static Future<String> saveImageToFile(XFile imageFile) async {
    if (imageFile == null) {
      return '';
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String imagePath = '${directory.path}/$uniqueFileName.jpg';

    File file = File(imagePath);
    await file.writeAsBytes(await imageFile.readAsBytes());

    return imagePath;
  }
}


// import 'dart:convert';
// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
//
// class ConvertImage
// {
//
//   static Future<String> convertImageToBase64(XFile imageFile) async {
//     if (imageFile == null) {
//       return '';
//     }
//
//     List<int> imageBytes = await imageFile.readAsBytes();
//     String base64String = base64Encode(imageBytes);
//     return base64String;
//   }
//
// }