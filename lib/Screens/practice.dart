
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Screens/practice1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class ItemCollectionTable extends StatefulWidget {
  @override
  _ItemCollectionTableState createState() => _ItemCollectionTableState();
}

class _ItemCollectionTableState extends State<ItemCollectionTable> {
  String? csvFilePath; // Store the file path

  Future<void> generateCSV() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('useritem')
        .orderBy('dateofPurchase')
        .get(); // Replace 'dateofPurchase' with the field name containing the datetime value

    List<List<dynamic>> rows = [];
    rows.add([
      'GeM Product ID',
      'Date of Purchase',
      'Item Description',
      'Quantity Procured',
      'QR Key',
      'Quantity Procured',
      'Remarks',
      'Supplier Email',
      'Supplier Phone',
      'Total Cost',
      'Unit Item Price',
      'Warranty',
    ]);

    querySnapshot.docs.forEach((doc) {
      Map<String, Object?> data = doc.data() as Map<String, Object?>;
      rows.add([
        data['GemProductId'],
        data['dateofPurchase'],
        data['itemDesc'],
        data['qrcode'],
        data['quantityProcured'],
        data['remarks'],
        data['supplierEmail'],
        data['supplierPhone'],
        data['unitItemPrice'],
        data['warranty'],
      ]);
    });

    String csv = const ListToCsvConverter().convert(rows);

    Directory? directory = await getApplicationDocumentsDirectory();
    if (directory != null) {
      File file = File('${directory.path}/useritem.csv');
      await file.writeAsString(csv);

      setState(() {
        csvFilePath = file.path; // Set the file path
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV file downloaded successfully.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to access storage directory.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Collection Table'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirestoreExporter()));
              },
              child: Text('Generate Data Table'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await generateCSV();
            //   },
            //   child: Text('CSV Generate'),
            // ),
            // SizedBox(height: 20,),
            // ElevatedButton(
            //   onPressed: () async {
            //     PermissionStatus storageStatus =
            //     await Permission.storage.request();
            //     if(storageStatus == PermissionStatus.granted)
            //       {
            //         Fluttertoast.showToast(msg: "Permission Granted");
            //       }
            //   },
            //   child: Text('Storage Permission'),
            // ),
            if (csvFilePath != null) // Display the file path
              SelectableText('CSV File Path: $csvFilePath'),
          ],
        ),
      ),
    );
  }
}
