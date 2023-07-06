//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Screens/addscreen.dart';
import 'package:login/Screens/qr_generator_screen.dart';


class GetKeyScreen extends StatefulWidget {
  const GetKeyScreen({Key? key, required this.documentId}) : super(key: key);
  final String documentId;

  @override
  State<GetKeyScreen> createState() => _GetKeyScreenState();
}

class _GetKeyScreenState extends State<GetKeyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('QR Key'),
      backgroundColor: Colors.teal,
      centerTitle: true,),
      body: Center(
        child: Container(
          height: 240,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Copy QR Generator Key Here!!",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SelectableText(
                widget.documentId,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 40,),
              MaterialButton(
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QrCodeGeneratorScreen()));
                  },
                  child: const Text(
                    "Generate QR",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),


            ],

          ),
        ),
      ),
    );
  }
}
