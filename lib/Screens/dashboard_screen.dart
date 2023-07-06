import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Screens/about_screen.dart';
import 'package:login/Screens/addscreen.dart';
import 'package:login/Screens/linkqr.dart';
import 'package:login/Screens/login_screen.dart';
import 'package:login/Screens/practice.dart';
import 'package:login/Screens/qr_generator_screen.dart';
import 'package:login/Screens/qr_print.dart';
import 'package:login/Screens/qr_scanner_screen.dart';
import 'package:login/helper/helper_function.dart';

import 'delete_image.dart';
import 'item_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              // borderRadius: const BorderRadius.only(
              //   bottomRight: Radius.circular(50),
              // ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text('Admin Dashboard',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Manage your items easily..!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: IconButton(
                    icon: Image.asset('assets/shutdown.png'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                title:
                                    const Text("Do you really want to Logout?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        HelperFunctions.saveUserLoggedInStatus(
                                            false);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          (Route<dynamic> route) => false,
                                        );
                                        Fluttertoast.showToast(
                                            msg: "Logout Successfully!!");
                                      },
                                      child: const Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("NO")),
                                ],
                              ),
                            );
                          });
                    },

                    iconSize: 60,
                    color: Colors.white,
                    //radius: 50,
                    //backgroundImage: AssetImage('assets/dashboard.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddScreen()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    // BorderRadius.only(topLeft: Radius.circular(150))),
                    BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('Add Item', CupertinoIcons.shopping_cart,
                        Colors.yellow.shade200),
                    // itemDashboard(
                    //     'Generate QR Code', CupertinoIcons.qrcode, Colors.teal),
                    // itemDashboard('View Items',
                    //  CupertinoIcons.qrcode_viewfinder, Colors.purple),
                    // itemDashboard(
                    //     'About', CupertinoIcons.question_square, Colors.brown),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QrCodeScannerScreen()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                //padding: const EdgeInsets.only(top: 80, left: 140, right: 30,bottom: 50),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    // itemDashboard('Add Items', CupertinoIcons.add_circled_solid,
                    //     Colors.indigo),
                    // itemDashboard(
                    //     'Generate QR Code', CupertinoIcons.qrcode, Colors.teal),
                    itemDashboard('View Item',
                        CupertinoIcons.qrcode_viewfinder, Colors.pink.shade100),
                    // itemDashboard(
                    //     'About', CupertinoIcons.question_square, Colors.brown),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SaveQrImageScreen()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    // BorderRadius.only(topLeft: Radius.circular(150))),
                    BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('Save QR', CupertinoIcons.photo_fill_on_rectangle_fill,
                        Colors.purple.shade100),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QrPrintScreen()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    // BorderRadius.only(topLeft: Radius.circular(150))),
                    BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('Print QR', CupertinoIcons.printer,
                        Colors.green.shade100),
                    // itemDashboard(
                    //     'Generate QR Code', CupertinoIcons.qrcode, Colors.teal),
                    // itemDashboard('View Items',
                    //  CupertinoIcons.qrcode_viewfinder, Colors.purple),
                    // itemDashboard(
                    //     'About', CupertinoIcons.question_square, Colors.brown),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeleteQRImage()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    // BorderRadius.only(topLeft: Radius.circular(150))),
                    BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('Delete QR', CupertinoIcons.delete,
                        Colors.red.shade100),
                    // itemDashboard(
                    //     'Generate QR Code', CupertinoIcons.qrcode, Colors.teal),
                    // itemDashboard('View Items',
                    //  CupertinoIcons.qrcode_viewfinder, Colors.purple),
                    // itemDashboard(
                    //     'About', CupertinoIcons.question_square, Colors.brown),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  ItemCollectionTable()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard(
                        'Item List', CupertinoIcons.layers, Colors.orange.shade200),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
            child: Container(
              color: Colors.teal.shade100,
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 60, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(150))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard(
                        'About', CupertinoIcons.info, Colors.orange.shade200),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 7),
                  color: Colors.teal.shade300.withOpacity(.6),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.rectangle,
                ),
                child: Icon(iconData, color: Colors.black)),
            const SizedBox(height: 8),
            Text(title.toString(),
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      );
}
