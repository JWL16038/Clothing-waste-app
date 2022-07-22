import 'dart:typed_data';

import 'package:clothing_waste_app/utils/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/item_model.dart';
import '../firebase/storage_methods.dart';
import '../widgets/text_input_field.dart';
import '../utils/images.dart';

import 'package:clothing_waste_app/ui/bottom_nav_bar_android.dart'
    as android_navbar;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _colourController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  Uint8List? _file;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addItem() async {
    if (_file == null) {
      showSnackBar("No image selected", context);
      return;
    }
    String userUID = _auth.currentUser!.uid;
    String itemPhotoUrl = await StorageMethods()
        .uploadImage('items/$userUID/', _nameController.text, _file!);
    final now = DateTime.now();

    if (_captionController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _descController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _colourController.text.isEmpty ||
        _conditionController.text.isEmpty ||
        _sizeController.text.isEmpty) {
      showSnackBar("Please fill in all the fields.", context);
      return;
    }

    if (int.tryParse(_priceController.text) == null ||
        int.tryParse(_sizeController.text) == null) {
      showSnackBar("Price or size must be a number.", context);
      return;
    }

    Item item = Item(
      caption: _captionController.text,
      itemName: _nameController.text,
      itemDesc: _descController.text,
      price: int.parse(_priceController.text),
      photoUrl: itemPhotoUrl,
      colour: _colourController.text,
      condition: _conditionController.text,
      size: int.parse(_sizeController.text),
      adddate: now.toString(),
    );
    //
    // _firestore.collection('items').doc(userUID).collection('forsale').doc().set(
    //       item.toJson(),
    //     );
    _firestore.collection('items').doc('forsale').collection(userUID).doc().set(
          item.toJson(),
        );

    showSnackBar("Success.", context);
  }

  void _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('List an item'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                  context,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                  context,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? TextButton(
            child: const Text(
              'Add an item',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () => _selectImage(context),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextInputField(
                    textEditingController: _captionController,
                    hintText: "Caption",
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _nameController,
                    hintText: "Item name",
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _descController,
                    hintText: "Write a description",
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _priceController,
                    hintText: "Price of item",
                    textInputType: TextInputType.number,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _colourController,
                    hintText: "Colour",
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _conditionController,
                    hintText: "Condition",
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  TextInputField(
                    textEditingController: _sizeController,
                    hintText: "Size",
                    textInputType: TextInputType.number,
                    isPass: false,
                  ),
                  TextButton(
                    onPressed: addItem,
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
