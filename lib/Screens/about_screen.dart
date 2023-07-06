import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
        title: const Text(
          "About EMU Inventory",
        ),
        leading: Icon(Icons.question_mark_outlined),
      ),
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              // SizedBox(
              //     height: 150,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Image.asset('assets/developer.png'),
              //     )),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Text(
                  "Welcome to EMU Inventory Management Application!\n\n "
                      "About the Application:\n\n"
                      "This application is a powerful inventory management solution that leverages QR code technology to streamline and optimize the inventory tracking processes. It is designed to simplify inventory management for Electrical Maintenance Department of NIT Calicut,"
                      " providing an efficient and user-friendly interface.\n\n"
                      "Key Features:\n\n"
                      " • Generate QR Code to link with items.\n "
                      " • Quickly scan QR codes to fetch the item details.\n"
                      " • Add or Update details of the items(only Admin).\n"
                      " • Delete items from Inventory(only Admin).\n\n"
                      "This Application is Developed by:\n\nIsha Gupta from MCA'23 as the major academic project under the Guidance of "
                      "Dr. Gopakumar G, Asst. Professor, Electrical Maintenance Unit of NIT Calicut.\n\n"
                      "Contact Information:"
                      "\n\nEmail: isha46259@gmail.com\nLinkedIn: Isha Gupta"
                      "\n\nThank you for using EMU Inventory Management Application.",
                  style: TextStyle(fontSize: 18.0, color: Colors.brown),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}