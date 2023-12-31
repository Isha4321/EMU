import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Screens/threexthree_screen.dart';
import 'package:login/Screens/twoxtwo_screen.dart';
import 'package:login/Screens/view_all_qr.dart';

import 'fourxfour_screen.dart';

class QrPrintScreen extends StatefulWidget {
  const QrPrintScreen({Key? key}) : super(key: key);

  @override
  State<QrPrintScreen> createState() => _QrPrintScreenState();
}

class _QrPrintScreenState extends State<QrPrintScreen> {
  List dropDownListData = [
    {"title": "2x2", "value": "1"},
    {"title": "3x3", "value": "2"},
    {"title": "4x4", "value": "3"},
    {"title": "All QR", "value": "4"},
  ];

  String defaultValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text("Choose Print Layout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          SizedBox(
            height: 250,
            child: Image.asset("assets/add.png"),
          ),
          InputDecorator(
            decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              contentPadding: const EdgeInsets.all(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  isDense: true,
                  value: defaultValue,
                  isExpanded: true,
                  menuMaxHeight: 350,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select layout",
                        ),
                        value: ""),
                    ...dropDownListData.map<DropdownMenuItem<String>>((data) {
                      return DropdownMenuItem(
                          child: Text(data['title']), value: data['value']);
                    }).toList(),
                  ],
                  onChanged: (value) {
                    print("selected Value $value");
                    setState(() {
                      defaultValue = value!;
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                //minWidth: MediaQuery.of(context).size.width,
                minWidth: 60,
                onPressed: () {
                  if (defaultValue == "") {
                    Fluttertoast.showToast(msg: "Please choose a layout");
                    //print("Please select a course");
                  } else {
                    if (defaultValue == '1') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  twoxtwoscreen()));
                    } else if (defaultValue == '2') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const threexthreeScreen()));
                    } else if (defaultValue == '3') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const fourxfourScreen()));
                    }
                    else if (defaultValue == '4') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewAllQrImages()));
                    }
                    //print("user selected course $defaultValue");
                  }
                  //signIn(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Submit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ]),
      ),
    );
  }
}