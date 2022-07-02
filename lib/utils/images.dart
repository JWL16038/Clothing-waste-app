import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if(file != null){
    return await file.readAsBytes();
  }
  //No image selected
  //showSnackBar("No image selected", context);
  print("No image selected");
}
