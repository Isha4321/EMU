import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Screens/dashboard_screen.dart';
import 'package:login/Screens/utils.dart';
import '../resources/add_data.dart';

class SaveQrImageScreen extends StatefulWidget {
  const SaveQrImageScreen({Key? key}) : super(key: key);

  @override
  State<SaveQrImageScreen> createState() => _SaveQrImageScreenState();
}

class _SaveQrImageScreenState extends State<SaveQrImageScreen> {
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController itemDescController = TextEditingController();

  Uint8List? _image;
  bool _isButtonDisabled = false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveDetails() async {
    if (_isButtonDisabled) return; // Disable button if already clicked
    setState(() {
      _isButtonDisabled = true;
    });

    String itemCode = itemCodeController.text;
    String itemDesc = itemDescController.text;
    String resp = await StoreData().saveData(
      ItemCode: itemCode,
      ItemDesc: itemDesc,
      file: _image!,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save QR"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : const CircleAvatar(
                    radius: 64,
                    backgroundImage: null,
                    backgroundColor: Colors.teal,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.browse_gallery_outlined),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: itemCodeController,
                decoration: const InputDecoration(
                  hintText: 'Item Code',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                controller: itemDescController,
                decoration: const InputDecoration(
                  hintText: 'Item Description',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : saveDetails,
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                child: const Text('Save QR'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
