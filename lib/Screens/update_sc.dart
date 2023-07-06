import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'dashboard_screen.dart';

class UpdatePagae extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> data;

  const UpdatePagae({Key? key, required this.documentId, required this.data})
      : super(key: key);

  @override
  State<UpdatePagae> createState() => _UpdatePagaeState();
}

class _UpdatePagaeState extends State<UpdatePagae> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference itemCollection =
  FirebaseFirestore.instance.collection('useritem');
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> initalData = {};
  bool _isLoading = false;
  DateTime? dateOfPurchase;
  DateTime? dateOfIssue;

  TextEditingController itemDescController = TextEditingController();
  TextEditingController dateofPurchaseController = TextEditingController();
  //TextEditingController DateOfIssueController = TextEditingController();
  TextEditingController QuantityProcuredController = TextEditingController();
  TextEditingController UnitItemPriceController = TextEditingController();
 // TextEditingController LocationController = TextEditingController();
  TextEditingController WarrantyController = TextEditingController();
  TextEditingController GeMProductIDController = TextEditingController();
  TextEditingController SellerEmailController = TextEditingController();
  TextEditingController SellerPhoneController = TextEditingController();
  TextEditingController RemarksController = TextEditingController();
  //TextEditingController AttendedByController = TextEditingController();
  double? result = 0, num1 = 0, num2 = 0;

  sub() {
    setState(() {
      num1 = double.parse(QuantityProcuredController.text);
      num2 = double.parse(UnitItemPriceController.text);
      result = (num1!*num2!);
      Fluttertoast.showToast(msg: "$result");
      // if (num1! >= num2!) {
      //   result = num1! - num2!;
      //   Fluttertoast.showToast(msg: "$result");
      // } else {
      //   Fluttertoast.showToast(msg: "enter correct values");
      // }
    });
  }

  @override
  void initState() {
    setState(() {
      initalData = widget.data;
    });
    itemDescController.text = initalData['itemDesc'];
    dateofPurchaseController.text = initalData['dateofPurchase'];
   // DateOfIssueController.text = initalData['dateofIssue'];
    QuantityProcuredController.text = initalData['quantityProcured'];
    UnitItemPriceController.text = initalData['unitItemPrice'];
   // LocationController.text = initalData['location'];
    RemarksController.text = initalData['remarks'];
   // AttendedByController.text = initalData['attendedBy'];
    WarrantyController.text = initalData['warranty'];
    GeMProductIDController.text = initalData['GemProductId'];
    SellerEmailController.text = initalData['supplierEmail'];
    SellerPhoneController.text = initalData['supplierPhone'];


  }

  @override
  Widget build(BuildContext context) {

    final ItemDescriptionField = TextFormField(
        autofocus: false,
        maxLines: 2,
        controller: itemDescController,
        keyboardType: TextInputType.text,
        validator: (value) {
          //RegExp regExp = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          itemDescController.text = value!;
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
        controller: dateofPurchaseController,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          dateofPurchaseController.text = value as String;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1961),
              lastDate: DateTime.now());
          if (pickedDate != null) {
            setState(() {
              // DateOfPurchase=pickedDate;
              dateofPurchaseController.text =
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
        ));
    // final DateOfIssueField = TextFormField(
    //     autofocus: false,
    //     controller: DateOfIssueController,
    //     // keyboardType: TextInputType.name,
    //
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return (" This field is required!");
    //       }
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
    //       DateOfIssueController.text = value as String;
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
        onSaved: (value) {
          QuantityProcuredController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Quantity In Stock",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final UnitItemPriceField = TextFormField(
        autofocus: false,
        //: QuantityIssuedController,
        controller: UnitItemPriceController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          UnitItemPriceController.text = value!;
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
    final SubButton = Material(
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
    //     onSaved: (value) {
    //       LocationController.text = value!;
    //     },
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
    //     //initialValue: initalData['attendedBy'],
    //     keyboardType: TextInputType.name,
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return (" This field is required!");
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       AttendedByController.text = value!;
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
    final WarrantyField = TextFormField(
        autofocus: false,
        controller: WarrantyController,
        keyboardType: TextInputType.text,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return (" This field is required!");
        //   }
        //   return null;
        // },
        onSaved: (value) {
          WarrantyController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Warranty Details",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final GeMProduct = TextFormField(
        autofocus: false,
        maxLines: 2,
        controller: GeMProductIDController,
        keyboardType: TextInputType.text,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return (" This field is required!");
        //   }
        //   return null;
        // },
        onSaved: (value) {
          GeMProductIDController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Invoice Details",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final SellersEmailField = TextFormField(
        autofocus: false,
        controller: SellerEmailController,
        keyboardType: TextInputType.number,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return (" This field is required!");
        //   }
        //   return null;
        // },
        onSaved: (value) {
          SellerEmailController.text = value!;
        },
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
            return (" This field is required!");
          }
          return null;
        },
        onSaved: (value) {
          SellerPhoneController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.production_quantity_limits_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Seller's Phone No.",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final RemarksField = TextFormField(
      maxLines: 5,
        autofocus: false,
        controller: RemarksController,
        //initialValue: initalData['remarks'],
        onSaved: (value) {
          RemarksController.text = value!;
        },
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
    final UpdateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            // Duration d = dateOfIssue!.difference(dateOfPurchase!);
            if (!_formKey.currentState!.validate()) {
              return;
            }
            // Duration d = dateOfIssue!.difference(dateOfPurchase!);
            // if (d.isNegative) {
            //   Fluttertoast.showToast(msg: "Enter valid date");
            // }
            else {
              final docItem = itemCollection.doc(widget.documentId);
              await docItem.update({
                'itemDesc': itemDescController.text,
                'dateofPurchase': dateofPurchaseController.text,
               // 'dateofIssue': DateOfIssueController.text,
                'quantityProcured': QuantityProcuredController.text,
                'unitItemPrice': UnitItemPriceController.text,
                'totalCost': result,
                //'location': LocationController.text,
                //'attendedBy': AttendedByController.text,
                'remarks': RemarksController.text,
                'GemProductId':  GeMProductIDController.text,
                'warranty':WarrantyController.text,
                'supplierEmail':SellerEmailController.text,
                'supplierPhone' : SellerPhoneController.text,
              });
              Fluttertoast.showToast(msg: "Item updated successfully");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }
          },
          child: const Text(
            "Update Item",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Item'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
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

                        Image.asset("assets/item.png"),
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
                        SubButton,
                        const SizedBox(height: 20),
                        WarrantyField,
                        SizedBox(height: 20,),
                        GeMProduct,
                        SizedBox(height: 20,),
                        SellersEmailField,
                        SizedBox(height: 20,),
                        SellersPhoneField,
                        const SizedBox(height: 20),
                        // LocationField,
                        // const SizedBox(height: 20),
                        // AttendedByField,
                        // const SizedBox(height: 20),
                        RemarksField,
                        const SizedBox(height: 20),
                        UpdateButton,
                        const SizedBox(height: 40),
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
