import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:login/Screens/getkey_screen.dart';
import 'package:login/Screens/viewitem.dart';
import '../model/item_model.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  // final fireStore = FirebaseFirestore.instance.collection('userItem');
  CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('useritem');

  //final fireStore=FirebaseFirestore.instance.collection('useritem');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  final ItemCodeController = TextEditingController();
  final ItemDescController = TextEditingController();
  final DateOfPurchaseController = TextEditingController();
  final DateOfIssueController = TextEditingController();
  final QuantityInStockController = TextEditingController();
  final QuantityIssuedController = TextEditingController();
  final BalancedStockController = TextEditingController();
  final LocationController = TextEditingController();
  final RemarksController = TextEditingController();
  final LinkQrController = TextEditingController();
  final AttendedByController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ItemDescriptionField = TextFormField(
        autofocus: false,
        controller: ItemDescController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        validator: (value) {
          //RegExp regExp = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" This field is required!");
          }

          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_to_photos_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Item Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final ItemCodeField = TextFormField(
        autofocus: false,
        controller: ItemCodeController,
        keyboardType: TextInputType.name,
        validator: (value) {
          // RegExp regExp = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" This field is required!");
          }

          return null;
        },
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.code),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Item Code",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final DateOfPurchaseField = TextFormField(
        autofocus: false,
        controller: DateOfPurchaseController,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }

          return null;
        },
        onSaved: (value) {},
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            setState(() {
              DateOfPurchaseController.text =
                  DateFormat('yyyy/MM/dd').format(pickedDate);
            });
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Date Of Purchase",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final DateOfIssueField = TextFormField(
        autofocus: false,
        controller: DateOfIssueController,
        // keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }

          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            setState(() {
              DateOfIssueController.text =
                  DateFormat('yyyy/MM/dd').format(pickedDate);
            });
          }
        },
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Date Of Issue",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final QuantityInStockField = TextFormField(
        autofocus: false,
        controller: QuantityInStockController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Quantity In Stock",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final QuantityIssuedField = TextFormField(
        autofocus: false,
        controller: QuantityIssuedController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.countertops_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Quantity Issued",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final BalancedStockField = TextFormField(
        autofocus: false,
        controller: BalancedStockController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.shopping_cart),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Balanced Stock",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final LocationField = TextFormField(
        autofocus: false,
        controller: LocationController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final AttendedByField = TextFormField(
        autofocus: false,
        controller: AttendedByController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Attended By",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final RemarksField = TextFormField(
        autofocus: false,
        controller: RemarksController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.comment),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Remarks",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final LinkQrField = TextFormField(
        autofocus: false,
        controller: LinkQrController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.qr_code_2),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Link Qr",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final AddButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            setState(() {
              _isLoading = true;
            });

            String id = DateTime.now().microsecondsSinceEpoch.toString();

            itemCollection.doc(id).set({
              'itemCode': id,
              'itemDesc': ItemDescController.text,
              'dateofPurchase': DateOfPurchaseController.text,
              'dateofIssue': DateOfIssueController.text,
              'quantityInStock': QuantityInStockController.text,
              'quantityIssued': QuantityIssuedController.text,
              'balancedStock': BalancedStockController.text,
              'location': LocationController.text,
              'attendedBy': AttendedByController.text,
              'remarks': RemarksController.text,
              'linkqr': LinkQrController.text,
            }).then((value) async {
              ItemCodeController.clear();
              ItemDescController.clear();
              DateOfPurchaseController.clear();
              DateOfIssueController.clear();
              QuantityInStockController.clear();
              QuantityIssuedController.clear();
              BalancedStockController.clear();
              LocationController.clear();
              AttendedByController.clear();
              RemarksController.clear();
              LinkQrController.clear();
              Fluttertoast.showToast(msg: "Item added successfully");
            }).catchError((error) {
              log(error.toString());
            });
          },
          child: const Text(
            "Add Item",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final KeyButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context)=>GetKeyScreen(documentId),
            //
            //     ));
          },
          child: const Text(
            "Get Key",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item In Inventory'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/additem.png"),
                      ItemCodeField,
                      const SizedBox(height: 20),
                      ItemDescriptionField,
                      const SizedBox(height: 20),
                      DateOfPurchaseField,
                      const SizedBox(height: 20),
                      DateOfIssueField,
                      const SizedBox(height: 20),
                      QuantityInStockField,
                      const SizedBox(height: 20),
                      QuantityIssuedField,
                      const SizedBox(height: 20),
                      BalancedStockField,
                      const SizedBox(height: 20),
                      LocationField,
                      const SizedBox(height: 20),
                      AttendedByField,
                      const SizedBox(height: 20),
                      RemarksField,
                      const SizedBox(height: 20),
                      LinkQrField,
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          AddButton,
                          const SizedBox(width: 60),
                          KeyButton,
                          const SizedBox(height: 40),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
