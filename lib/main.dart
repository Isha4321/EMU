import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/dashboard_screen.dart';
import 'package:login/Screens/home_screen.dart';
import 'package:login/Screens/login_screen.dart';
import 'package:login/Screens/splash_screen.dart';
import 'package:login/Screens/user_screen.dart';
import 'package:login/helper/helper_function.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //check if user is in the stack

  var auth = FirebaseAuth.instance;
  bool _isSignedIn = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User?user) {
      if(user != null && mounted){
        setState(() {
          _isSignedIn = true;
        });
      }
    });
  }


  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isSignedIn ? const UserDashboardScreen() : SplashScreen(),
    );
  }
}