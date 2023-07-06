import 'dart:developer';
import 'dart:io';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('useritem');

  //final fireStore=FirebaseFirestore.instance.collection('useritem');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  DateTime? dateOfPurchase;
  DateTime? dateOfIssue;

  //final ItemCodeController = TextEditingController();
  final ItemDescController = TextEditingController();
  final DateOfPurchaseController = TextEditingController();
  //final DateOfIssueController = TextEditingController();
  final QuantityProcuredController = TextEditingController();
  final UnitItemPriceController = TextEditingController();
  final WarrantyController = TextEditingController();
  final GeMProductIDController = TextEditingController();
  final SellerEmailController = TextEditingController();
  final SellerPhoneController = TextEditingController();
 // final LocationController = TextEditingController();
  final RemarksController = TextEditingController();
  //final LinkQrController = TextEditingController();
  //final AttendedByController = TextEditingController();
  double? result = 0, num1 = 0, num2 = 0;
  String id = DateTime.now().microsecondsSinceEpoch.toString();

  sub() {
    setState(() {
      num1 = double.parse(QuantityProcuredController.text);
      num2 = double.parse(UnitItemPriceController.text);

      result = (num1!*num2!);
      Fluttertoast.showToast(msg: "$result");
      // if (num1! >= num2!) {
      //   result = num1! - num2!;
      //   Fluttertoast.showToast(msg: "$result");
      // }
      // //result = num1! - num2!;
      //
      // else {
      //   Fluttertoast.showToast(msg: "enter correct values");
      // }
    });
  }

  // DateTime? purchasedate;
  // DateTime? issuedate;
  // var difference;

  @override
  Widget build(BuildContext context) {
    final ItemDescriptionField = TextFormField(
        autofocus: false,
        maxLines: 2,
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

    final DateOfPurchaseField = TextFormField(
      autofocus: false,
      controller: DateOfPurchaseController,
      validator: (value) {
        if (value!.isEmpty) {
          return (" This field is required!");
        }
        return null;
      },
      onSaved: (value) {
        //firstNameEditingController.text = value!;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1961),
            lastDate: DateTime.now());
        if (pickedDate != null) {
          setState(() {
            DateOfPurchaseController.text =
                DateFormat('yyyy/MM/dd').format(pickedDate);
            dateOfPurchase = pickedDate;
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
      ),
    );
    // final DateOfIssueField = TextFormField(
    //     autofocus: false,
    //     controller: DateOfIssueController,
    //     // keyboardType: TextInputType.name,
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return (" This field is required!");
    //       }
    //
    //       return null;
    //     },
    //     onTap: () async {
    //       DateTime? pickedDate = await showDatePicker(
    //           context: context,
    //           initialDate: DateTime.now(),
    //           firstDate: DateTime(1961),
    //           lastDate: DateTime.now());
    //       if (pickedDate != null) {
    //         setState(() {
    //           DateOfIssueController.text =
    //               DateFormat('yyyy/MM/dd').format(pickedDate);
    //           dateOfIssue = pickedDate;
    //         });
    //       }
    //     },
    //     onSaved: (value) {
    //       //firstNameEditingController.text = value!;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.date_range_sharp),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       labelText: "Date Of Issue",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));
    final QuantityProcured = TextFormField(
        autofocus: false,
        controller: QuantityProcuredController,
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
          labelText: "Quantity Procured",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final WarrantyField = TextFormField(
        autofocus: false,
        controller: WarrantyController,
        keyboardType: TextInputType.text,
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Warranty Details",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final GeMProductId = TextFormField(
        autofocus: false,
        maxLines: 2,
        controller: GeMProductIDController,
        keyboardType: TextInputType.text,
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "GeMProductID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final SellersEmailField = TextFormField(
        autofocus: false,
        controller: SellerEmailController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email of the Seller..");
          }
          if (!RegExp("^[a-z0-9+_.-]+@[a-z]+.[a-z]").hasMatch(value)) {
            return ("Please Enter a valid Email");
          }
          return null;
        },
        onSaved: (value) {},
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Seller's Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final SellersPhoneField = TextFormField(
        autofocus: false,
        controller: SellerPhoneController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Contact Number of the Supplier!");
          } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value)) {
            return ("Please Enter Valid Contact Number!");
          }
          return null;
        },
        onSaved: (value) {
          //firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.contact_mail_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Seller's Contact ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final UnitItemPriceField = TextFormField(
        autofocus: false,
        controller: UnitItemPriceController,
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
          labelText: "Unit Item Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final MulButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            sub();
          },
          child: const Text(
            "Click to calculate total cost",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
    );
    // final LocationField = TextFormField(
    //     autofocus: false,
    //     controller: LocationController,
    //     keyboardType: TextInputType.text,
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.location_city_outlined),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       labelText: "Location",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));
    // final AttendedByField = TextFormField(
    //     autofocus: false,
    //     controller: AttendedByController,
    //     keyboardType: TextInputType.name,
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return (" This field is required!");
    //       }
    //       return null;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: const Icon(Icons.person_outlined),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       labelText: "Attended By",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));
    final RemarksField = TextFormField(
        autofocus: false,
        maxLines: 5,
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

    final AddButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
             } else {
            //   Duration d = dateOfIssue!.difference(dateOfPurchase!);
            //   if (d.isNegative) {
            //     Fluttertoast.showToast(msg: "Enter valid date");
            //   } else {
                setState(() {
                  _isLoading = true;
                });
                // Duration d = dateOfIssue!.difference(dateOfPurchase!);
                // if (d.isNegative) {
                // Fluttertoast.showToast(msg: "Enter valid date");
                //} else {
                itemCollection.doc(id).set({
                  //'itemCode': id,
                  'itemDesc': ItemDescController.text,
                  'dateofPurchase': DateOfPurchaseController.text,
                 // 'dateofIssue': DateOfIssueController.text,
                  'quantityProcured': QuantityProcuredController.text,
                  'unitItemPrice': UnitItemPriceController.text,
                  'totalCost': result,
                 // 'location': LocationController.text,
                 // 'attendedBy': AttendedByController.text,
                  'remarks': RemarksController.text,
                  'qrcode': id,
                  'GemProductId': GeMProductIDController.text,
                  'warranty': WarrantyController.text,
                  'supplierEmail': SellerEmailController.text,
                  'supplierPhone': SellerPhoneController.text,
                }).then((value) async {
                  //ItemCodeController.clear();
                  ItemDescController.clear();
                  DateOfPurchaseController.clear();
                 // DateOfIssueController.clear();
                  QuantityProcuredController.clear();
                  UnitItemPriceController.clear();
                 // LocationController.clear();
                 // AttendedByController.clear();
                  RemarksController.clear();
                  //LinkQrController.clear();
                  GeMProductIDController.clear();
                  WarrantyController.clear();
                  SellerPhoneController.clear();
                  SellerEmailController.clear();
                  Fluttertoast.showToast(msg: "Item added successfully");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetKeyScreen(documentId: id),
                      ));
                }).catchError((error) {
                  log(error.toString());
                });
              }
            },

          child: const Text(
            "Add Item",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Item'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        //backgroundColor: Colors.teal.shade100,
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
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset("assets/add.png")),
                        // ItemCodeField,
                        const SizedBox(height: 20),
                        ItemDescriptionField,
                        const SizedBox(height: 20),
                        DateOfPurchaseField,
                        const SizedBox(height: 20),
                        // DateOfIssueField,
                        // const SizedBox(height: 20),
                        QuantityProcured,
                        const SizedBox(height: 20),
                        UnitItemPriceField,
                        const SizedBox(height: 20),
                        MulButton,
                        const SizedBox(height: 20),
                        WarrantyField,
                        SizedBox(
                          height: 20,
                        ),
                        GeMProductId,
                        SizedBox(
                          height: 20,
                        ),
                        SellersEmailField,
                        const SizedBox(height: 20),
                        SellersPhoneField,
                        const SizedBox(height: 20),
                        // LocationField,
                        // const SizedBox(height: 20),
                        // AttendedByField,
                        // const SizedBox(height: 20),
                        RemarksField,
                        const SizedBox(height: 20),
                        AddButton,
                        const SizedBox(width: 60),
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
      ),
    );
  }
}
