import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteQRImage extends StatefulWidget {
  const DeleteQRImage({Key? key}) : super(key: key);

  @override
  State<DeleteQRImage> createState() => _DeleteQRImageState();
}

class _DeleteQRImageState extends State<DeleteQRImage> {
  TextEditingController idController = TextEditingController();

  Future<void> deleteCombinedData() async {
    final String id = idController.text;

    final useritemSnapshot =
        await FirebaseFirestore.instance.collection('useritem').get();
    //final QRImagesSnapshot = await FirebaseFirestore.instance.collection('QRImages').get();

    final batch = FirebaseFirestore.instance.batch();
    for (final useritemDoc in useritemSnapshot.docs) {
      final useritemData = useritemDoc.data();
      final itemId = useritemData['qrcode'];

      if (itemId == id) {
        batch.delete(useritemDoc.reference);
        final qrImagesSnapshot = await FirebaseFirestore.instance
            .collection('QRImages')
            .where('ItemCode', isEqualTo: itemId)
            .get();

        for (final qrImageDoc in qrImagesSnapshot.docs) {
          batch.delete(qrImageDoc.reference);
        }
      }
    }

    //   final matchingQR  = QRImagesSnapshot.docs.firstWhere((QRImagesDoc)=>QRImagesDoc.data()['ItemCode']=itemId,
    //   );
    //   if(matchingQR != null && itemId == qrcode )
    //     {
    //       batch.delete(useritemDoc.reference);
    //       batch.delete(matchingQR.reference);
    //     }
    // }
    await batch.commit();
    Fluttertoast.showToast(msg: "QR Deleted");
    idController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete QR"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 55,
              ),
              Container(
                child: Image.asset("assets/delete.png"),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Item Code',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: deleteCombinedData,
                style: ElevatedButton.styleFrom(primary: Colors.teal),
                child: const Text('Delete QR'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
