// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:typed_data/typed_data.dart';
//
// class FirestoreExporter extends StatefulWidget {
//   @override
//   _FirestoreExporterState createState() => _FirestoreExporterState();
// }
//
// class _FirestoreExporterState extends State<FirestoreExporter> {
//   final collectionPath = 'useritem'; // Replace with your collection path
//   final batchSize = 500; // Adjust batch size as per your needs
//   bool isExporting = false;
//   String downloadURL = '';
//
//   Future<String> exportFirestoreCollection(String collectionPath) async {
//     List<Map<String, dynamic>> data = [];
//     QuerySnapshot? snapshot;
//
//     do {
//       if (snapshot != null) {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(batchSize)
//             .get();
//       } else {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .limit(batchSize)
//             .get();
//       }
//
//       List<Map<String, dynamic>> batchData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       data.addAll(batchData);
//     } while (snapshot.docs.length == batchSize);
//
//     String jsonData = jsonEncode(data);
//     return jsonData;
//   }
//
//   Future<String> uploadJSONFile(String jsonData) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final filename = 'firestore_collection.json';
//     final fileRef = storageRef.child(filename);
//     final uploadTask = fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
//     await uploadTask.whenComplete(() => null);
//     return fileRef.getDownloadURL();
//   }
//
//   void exportFirestoreCollectionToStorage() async {
//     setState(() {
//       isExporting = true;
//     });
//
//     try {
//       String jsonData = await exportFirestoreCollection(collectionPath);
//       String url = await uploadJSONFile(jsonData);
//
//       setState(() {
//         downloadURL = url;
//       });
//
//       // Provide the download URL to the user
//       print('Download URL: $downloadURL');
//       // You can use the downloadURL to display a download link to the user
//     } catch (error) {
//       // Handle any errors that occur during export or upload
//       print('Error exporting Firestore collection: $error');
//     } finally {
//       setState(() {
//         isExporting = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Exporter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
//               child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
//             ),
//             SizedBox(height: 20.0),
//             if (downloadURL.isNotEmpty)
//               Text(
//                 'Download URL:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             if (downloadURL.isNotEmpty)
//               Text(downloadURL),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:typed_data/typed_data.dart';
//
// class FirestoreExporter extends StatefulWidget {
//   @override
//   _FirestoreExporterState createState() => _FirestoreExporterState();
// }
// data table link is not clickable
// class _FirestoreExporterState extends State<FirestoreExporter> {
//   final collectionPath = 'useritem'; // Replace with your collection path
//   final batchSize = 500; // Adjust batch size as per your needs
//   bool isExporting = false;
//   String downloadURL = '';
//   List<Map<String, dynamic>> data = [];
//
//   Future<String> exportFirestoreCollection(String collectionPath) async {
//     QuerySnapshot? snapshot;
//
//     do {
//       if (snapshot != null) {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(batchSize)
//             .get();
//       } else {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .limit(batchSize)
//             .get();
//       }
//
//       List<Map<String, dynamic>> batchData = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//       data.addAll(batchData);
//     } while (snapshot.docs.length == batchSize);
//
//     String jsonData = jsonEncode(data);
//     return jsonData;
//   }
//
//   Future<String> uploadJSONFile(String jsonData) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final filename = 'firestore_collection.json';
//     final fileRef = storageRef.child(filename);
//     final uploadTask =
//     fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
//     await uploadTask.whenComplete(() => null);
//     return fileRef.getDownloadURL();
//   }
//
//   void exportFirestoreCollectionToStorage() async {
//     setState(() {
//       isExporting = true;
//     });
//
//     try {
//       String jsonData = await exportFirestoreCollection(collectionPath);
//       String url = await uploadJSONFile(jsonData);
//
//       setState(() {
//         downloadURL = url;
//       });
//
//       // Provide the download URL to the user
//       print('Download URL: $downloadURL');
//       // You can use the downloadURL to display a download link to the user
//     } catch (error) {
//       // Handle any errors that occur during export or upload
//       print('Error exporting Firestore collection: $error');
//     } finally {
//       setState(() {
//         isExporting = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Exporter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
//               child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
//             ),
//             SizedBox(height: 20.0),
//             if (downloadURL.isNotEmpty)
//               Text(
//                 'Download URL:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             if (downloadURL.isNotEmpty)
//               Text(downloadURL),
//             SizedBox(height: 20.0),
//             if (data.isNotEmpty)
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: data[0]
//                         .keys
//                         .map((key) => DataColumn(label: Text(key)))
//                         .toList(),
//                     rows: data
//                         .map((row) => DataRow(
//                       cells: row.values
//                           .map((value) => DataCell(Text('$value')))
//                           .toList(),
//                     ))
//                         .toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// data table modified link is clickable but not
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:typed_data/typed_data.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class FirestoreExporter extends StatefulWidget {
//   @override
//   _FirestoreExporterState createState() => _FirestoreExporterState();
// }
//
// class _FirestoreExporterState extends State<FirestoreExporter> {
//   final collectionPath = 'useritem'; // Replace with your collection path
//   final batchSize = 500; // Adjust batch size as per your needs
//   bool isExporting = false;
//   String downloadURL = '';
//   List<Map<String, dynamic>> data = [];
//
//   Future<String> exportFirestoreCollection(String collectionPath) async {
//     QuerySnapshot? snapshot;
//
//     do {
//       if (snapshot != null) {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(batchSize)
//             .get();
//       } else {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .limit(batchSize)
//             .get();
//       }
//
//       List<Map<String, dynamic>> batchData = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//       data.addAll(batchData);
//     } while (snapshot.docs.length == batchSize);
//
//     String jsonData = jsonEncode(data);
//     return jsonData;
//   }
//
//   Future<String> uploadJSONFile(String jsonData) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final filename = 'firestore_collection.json';
//     final fileRef = storageRef.child(filename);
//     final uploadTask =
//     fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
//     await uploadTask.whenComplete(() => null);
//     return fileRef.getDownloadURL();
//   }
//
//   void exportFirestoreCollectionToStorage() async {
//     setState(() {
//       isExporting = true;
//     });
//
//     try {
//       String jsonData = await exportFirestoreCollection(collectionPath);
//       String url = await uploadJSONFile(jsonData);
//
//       setState(() {
//         downloadURL = url;
//       });
//
//       // Provide the download URL to the user
//       print('Download URL: $downloadURL');
//       // You can use the downloadURL to display a download link to the user
//     } catch (error) {
//       // Handle any errors that occur during export or upload
//       print('Error exporting Firestore collection: $error');
//     } finally {
//       setState(() {
//         isExporting = false;
//       });
//     }
//   }
//
//   void launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       print('Could not launch URL: $url');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Exporter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
//               child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
//             ),
//             SizedBox(height: 20.0),
//             if (downloadURL.isNotEmpty)
//               GestureDetector(
//                 onTap: () => launchURL(downloadURL),
//                 child: Text(
//                   'Download URL:',
//                   style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
//                 ),
//               ),
//             if (downloadURL.isNotEmpty)
//               GestureDetector(
//                 onTap: () => launchURL(downloadURL),
//                 child: Text(
//                   downloadURL,
//                   style: TextStyle(decoration: TextDecoration.underline),
//                 ),
//               ),
//             SizedBox(height: 20.0),
//             if (data.isNotEmpty)
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: data[0]
//                         .keys
//                         .map((key) => DataColumn(label: Text(key)))
//                         .toList(),
//                     rows: data
//                         .map((row) => DataRow(
//                       cells: row.values
//                           .map((value) => DataCell(Text('$value')))
//                           .toList(),
//                     ))
//                         .toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// code without share button
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/rendering.dart';
// import 'package:typed_data/typed_data.dart';
// import 'package:share_plus/share_plus.dart';
//
// class FirestoreExporter extends StatefulWidget {
//   @override
//   _FirestoreExporterState createState() => _FirestoreExporterState();
// }
//
// class _FirestoreExporterState extends State<FirestoreExporter> {
//   final collectionPath = 'useritem'; // Replace with your collection path
//   final batchSize = 500; // Adjust batch size as per your needs
//   bool isExporting = false;
//   List<Map<String, dynamic>> data = [];
//   final widgetKey = GlobalKey();
//
//   Future<String> exportFirestoreCollection(String collectionPath) async {
//     QuerySnapshot? snapshot;
//
//     do {
//       if (snapshot != null) {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(batchSize)
//             .get();
//       } else {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .limit(batchSize)
//             .get();
//       }
//
//       List<Map<String, dynamic>> batchData = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//       data.addAll(batchData);
//     } while (snapshot.docs.length == batchSize);
//
//     return jsonEncode(data);
//   }
//
//   Future<String> uploadJSONFile(String jsonData) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final filename = 'firestore_collection.json';
//     final fileRef = storageRef.child(filename);
//     final uploadTask =
//     fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
//     await uploadTask.whenComplete(() => null);
//     return fileRef.getDownloadURL();
//   }
//
//   Future<Uint8List> convertWidgetToImage(GlobalKey widgetKey) async {
//     RenderRepaintBoundary boundary =
//     widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData =
//     await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData!.buffer.asUint8List();
//   }
//
//   void exportFirestoreCollectionToStorage() async {
//     setState(() {
//       isExporting = true;
//     });
//
//     try {
//       String jsonData = await exportFirestoreCollection(collectionPath);
//
//       setState(() {
//         data = jsonDecode(jsonData).cast<Map<String, dynamic>>();
//       });
//
//       final imageBytes = await convertWidgetToImage(widgetKey);
//
//       final storageRef = FirebaseStorage.instance.ref();
//       final filename = 'firestore_collection.png';
//       final fileRef = storageRef.child(filename);
//       final uploadTask = fileRef.putData(imageBytes);
//       await uploadTask.whenComplete(() => null);
//       String url = await fileRef.getDownloadURL();
//
//       // Provide the download URL to the user
//       print('Download URL: $url');
//       // You can use the downloadURL to display a download link to the user
//
//       await Share.shareFiles([url],
//           text: 'Sharing Firestore Collection',
//           mimeTypes: ['image/png'],
//           subject: 'Firestore Collection');
//
//     } catch (error) {
//       // Handle any errors that occur during export or upload
//       print('Error exporting Firestore collection: $error');
//     } finally {
//       setState(() {
//         isExporting = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Exporter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
//               child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
//             ),
//             SizedBox(height: 20.0),
//             if (data.isNotEmpty)
//               Expanded(
//                 child: RepaintBoundary(
//                   key: widgetKey,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                       columns: data[0]
//                           .keys
//                           .map((key) => DataColumn(label: Text(key)))
//                           .toList(),
//                       rows: data
//                           .map((row) => DataRow(
//                         cells: row.values
//                             .map((value) => DataCell(Text('$value')))
//                             .toList(),
//                       ))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// blur image
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FirestoreExporter extends StatefulWidget {
  @override
  _FirestoreExporterState createState() => _FirestoreExporterState();
}

class _FirestoreExporterState extends State<FirestoreExporter> {
  final collectionPath = 'useritem'; // Replace with your collection path
  final batchSize = 500; // Adjust batch size as per your needs
  bool isExporting = false;
  String downloadURL = '';
  List<Map<String, dynamic>> data = [];
  final dataTableKey = GlobalKey();

  Future<String> exportFirestoreCollection(String collectionPath) async {
    QuerySnapshot? snapshot;

    do {
      if (snapshot != null) {
        snapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .startAfterDocument(snapshot.docs.last)
            .limit(batchSize)
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .limit(batchSize)
            .get();
      }

      List<Map<String, dynamic>> batchData = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      data.addAll(batchData);
    } while (snapshot.docs.length == batchSize);

    String jsonData = jsonEncode(data);
    return jsonData;
  }

  Future<String> uploadJSONFile(String jsonData) async {
    final storageRef = FirebaseStorage.instance.ref();
    final filename = 'firestore_collection.json';
    final fileRef = storageRef.child(filename);
    final uploadTask =
    fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
    await uploadTask.whenComplete(() => null);
    return fileRef.getDownloadURL();
  }

  Future<Uint8List> convertWidgetToImage(GlobalKey key) async {
    RenderRepaintBoundary boundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void exportFirestoreCollectionToStorage() async {
    setState(() {
      isExporting = true;
    });

    try {
      String jsonData = await exportFirestoreCollection(collectionPath);
      String url = await uploadJSONFile(jsonData);

      setState(() {
        downloadURL = url;
      });

      // Provide the download URL to the user
      print('Download URL: $downloadURL');
      // You can use the downloadURL to display a download link to the user
    } catch (error) {
      // Handle any errors that occur during export or upload
      print('Error exporting Firestore collection: $error');
    } finally {
      setState(() {
        isExporting = false;
      });
    }
  }

  void shareDataTable() async {
    try {
      final imageBytes = await convertWidgetToImage(dataTableKey);
      final tempDir = await getTemporaryDirectory();
      final imageFile = await File('${tempDir.path}/table.png').create();
      await imageFile.writeAsBytes(imageBytes);

      await Share.shareFiles(
        [imageFile.path],
        subject: 'Shared DataTable',
        text: 'Sharing DataTable from Firestore Exporter',
      );
    } catch (error) {
      print('Error sharing DataTable: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Exporter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
              child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
            ),
            SizedBox(height: 20.0),
            if (downloadURL.isNotEmpty)
              Text(
                'Download URL:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (downloadURL.isNotEmpty)
              Text(downloadURL),
            SizedBox(height: 20.0),
            if (data.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: RepaintBoundary(
                    key: dataTableKey,
                    child: DataTable(
                      columns: data[0]
                          .keys
                          .map((key) => DataColumn(label: Text(key)))
                          .toList(),
                      rows: data
                          .map((row) => DataRow(
                        cells: row.values
                            .map((value) => DataCell(Text('$value')))
                            .toList(),
                      ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20.0),
            if (data.isNotEmpty)
              ElevatedButton(
                onPressed: shareDataTable,
                child: Text('Share DataTable'),
              ),
          ],
        ),
      ),
    );
  }
}
// not showing full screen
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:typed_data/typed_data.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:flutter/rendering.dart';
//
// class FirestoreExporter extends StatefulWidget {
//   @override
//   _FirestoreExporterState createState() => _FirestoreExporterState();
// }
//
// class _FirestoreExporterState extends State<FirestoreExporter> {
//   final collectionPath = 'useritem'; // Replace with your collection path
//   final batchSize = 500; // Adjust batch size as per your needs
//   bool isExporting = false;
//   String downloadURL = '';
//   List<Map<String, dynamic>> data = [];
//   GlobalKey globalKey = GlobalKey();
//
//   Future<String> exportFirestoreCollection(String collectionPath) async {
//     QuerySnapshot? snapshot;
//
//     do {
//       if (snapshot != null) {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .startAfterDocument(snapshot.docs.last)
//             .limit(batchSize)
//             .get();
//       } else {
//         snapshot = await FirebaseFirestore.instance
//             .collection(collectionPath)
//             .limit(batchSize)
//             .get();
//       }
//
//       List<Map<String, dynamic>> batchData = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//       data.addAll(batchData);
//     } while (snapshot.docs.length == batchSize);
//
//     String jsonData = jsonEncode(data);
//     return jsonData;
//   }
//
//   Future<String> uploadJSONFile(String jsonData) async {
//     final storageRef = FirebaseStorage.instance.ref();
//     final filename = 'firestore_collection.json';
//     final fileRef = storageRef.child(filename);
//     final uploadTask =
//     fileRef.putData(Uint8List.fromList(utf8.encode(jsonData)));
//     await uploadTask.whenComplete(() => null);
//     return fileRef.getDownloadURL();
//   }
//
//   void exportFirestoreCollectionToStorage() async {
//     setState(() {
//       isExporting = true;
//     });
//
//     try {
//       String jsonData = await exportFirestoreCollection(collectionPath);
//       String url = await uploadJSONFile(jsonData);
//
//       setState(() {
//         downloadURL = url;
//       });
//
//       // Provide the download URL to the user
//       print('Download URL: $downloadURL');
//       // You can use the downloadURL to display a download link to the user
//     } catch (error) {
//       // Handle any errors that occur during export or upload
//       print('Error exporting Firestore collection: $error');
//     } finally {
//       setState(() {
//         isExporting = false;
//       });
//     }
//   }
//
//   Future<void> captureAndShare() async {
//     try {
//       RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       if (boundary.debugNeedsPaint) {
//         await Future.delayed(const Duration(milliseconds: 20));
//         return captureAndShare();
//       }
//       final image = await boundary.toImage(pixelRatio: 1.0); // Keep the pixel ratio as 1.0
//       ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
//       if (byteData != null) {
//         Uint8List pngBytes = byteData.buffer.asUint8List();
//         final tempDir = await getTemporaryDirectory();
//         final tempPath = '${tempDir.path}/table.png';
//         File(tempPath).writeAsBytesSync(pngBytes);
//
//         await Share.shareFiles([tempPath], text: 'Sharing Table');
//       }
//     } catch (error) {
//       print('Error capturing and sharing: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Exporter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: isExporting ? null : exportFirestoreCollectionToStorage,
//               child: Text(isExporting ? 'Exporting...' : 'Export Collection'),
//             ),
//             SizedBox(height: 20.0),
//             if (downloadURL.isNotEmpty)
//               Text(
//                 'Download URL:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             if (downloadURL.isNotEmpty)
//               Text(downloadURL),
//             SizedBox(height: 20.0),
//             if (data.isNotEmpty)
//               Expanded(
//                 child: RepaintBoundary(
//                   key: globalKey,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                       columns: data[0]
//                           .keys
//                           .map((key) => DataColumn(label: Text(key)))
//                           .toList(),
//                       rows: data
//                           .map((row) => DataRow(
//                         cells: row.values
//                             .map((value) => DataCell(Text('$value')))
//                             .toList(),
//                       ))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ElevatedButton(
//               onPressed: captureAndShare,
//               child: Text('Share Table'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








