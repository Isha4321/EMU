import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Screens/dashboard_screen.dart';
import 'package:login/Screens/update_sc.dart';

class GetItem extends StatelessWidget {
  final String documentId;

  GetItem(this.documentId);

  @override
  Widget build(BuildContext context) {
    print("code will start from here ");
    CollectionReference itemCollection =
        FirebaseFirestore.instance.collection('useritem');
    print("Code will stop here ");
    return FutureBuilder<DocumentSnapshot>(
      future: itemCollection.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Container(
              padding: EdgeInsets.fromLTRB(20, 400, 20, 20),
              child: Text(
                "Document does not exist!!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.red),
              ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 800,
                  color: Colors.teal.shade50,
                  padding:
                      EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Item Details: ',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        'QR Key: ${data['qrcode']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Description.: ${data['itemDesc']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Quantity Procured: ${data['quantityProcured']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'Date Of Issue: ${data['dateofIssue']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        'Unit Item Price: ${data['unitItemPrice']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total Cost: ${data['totalCost']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Warranty: ${data['warranty']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'GeMProductId: ${data['GemProductId']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Supplier Email: ${data['supplierEmail']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Supplier Contact: ${data['supplierPhone']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'Warranty Details: ${data['warranty']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Invoice Details: ${data['invoice']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Sellers Phone No.: ${data['supplierPhone']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Sellers Email: ${data['supplierEmail']}',
                      //   style: const TextStyle(
                      //     decoration: TextDecoration.none,
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        'Remarks: ${data['remarks']}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MaterialButton(
                              color: Colors.teal,

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdatePagae(
                                              data: data,
                                              documentId: documentId,
                                            )));
                              },
                              child: const Text(
                                "Update",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 60,
                          ),
                          // MaterialButton(
                          //     color: Colors.teal,
                          //     //padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          //     //minWidth: MediaQuery.of(context).size.width,
                          //     onPressed: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (context) {
                          //             return Container(
                          //               child: AlertDialog(
                          //                 title: const Text(
                          //                     "Do you really want to Delete the Item?"),
                          //                 actions: [
                          //                   TextButton(
                          //                       onPressed: () {
                          //                         itemCollection
                          //                             .doc(documentId)
                          //                             .delete();
                          //                         Fluttertoast.showToast(
                          //                             msg: "Item Deleted");
                          //                         Navigator.pushAndRemoveUntil(
                          //                           context,
                          //                           MaterialPageRoute(
                          //                               builder: (context) =>
                          //                                   const MyHomePage()),
                          //                           (Route<dynamic> route) =>
                          //                               false,
                          //                         );
                          //                       },
                          //                       child: const Text("YES")),
                          //                   TextButton(
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       },
                          //                       child: const Text("NO")),
                          //                 ],
                          //               ),
                          //             );
                          //           });
                          //     },
                          //     // onPressed: () {
                          //     //   itemCollection.doc(documentId).delete();
                          //     //   Fluttertoast.showToast(msg: "Item Deleted");
                          //     // },
                          //     child: const Text(
                          //       "Delete",
                          //       textAlign: TextAlign.end,
                          //       style: TextStyle(
                          //           fontSize: 20,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold),
                          //     )),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                    ],
                  ),
                );
              });
        }

        return Center(
          child: const Text(
            "loading",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
