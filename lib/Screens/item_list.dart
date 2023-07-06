import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  File? csvFile;
  Future<void> generateCSV() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('useritem')
        .orderBy('dateofPurchase').get();
    List<List<dynamic>> rows = [];
    rows.add([
      'Item Description',
      'Date of Purchase',
      'Date of Issue',
      'Quantity in Stock',
      'Quantity Issued',
      'Balanced Stock',
      'Location',
      'Attended By',
      'Remarks',
      'QR Code',
      'Invoice',
      'Warranty Details',
      'Supplier Email',
      'Supplier Phone',

    ]);

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        rows.add([
          data['itemDesc'],
          data['dateofPurchase'],
          data['dateofIssue'],
          data['quantityInStock'],
          data['quantityIssued'],
          data['balancedStock'],
          data['location'],
          data['attendedBy'],
          data['remarks'],
          data['qrcode'],
          data['invoice'],
          data['warranty'],
          data['supplierEmail'],
          data['supplierPhone'],
        ]);
    });
    String csv = const ListToCsvConverter().convert(rows);

    Directory? directory = await getApplicationDocumentsDirectory();
    if (directory != null) {
      File file = File('${directory.path}/useritem.csv');
      await file.writeAsString(csv);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV file downloaded successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to access storage directory.'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print Table'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await generateCSV();
              },
              child: Text('Download CSV'),
            ),
          ],
        ),
      ),

    );
  }
}

