import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login/Screens/login_screen.dart';
import 'package:login/Screens/registration_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2),(){


      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.teal.shade100,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const[

              Text('Welcome to EMU '
                , style: TextStyle(
                    fontSize: 30,

                    fontWeight: FontWeight.w700,
                    color:Colors.black
                ),),
              Text('Inventory Management ', style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color:Colors.black
              ),),
              SizedBox(height: 50,),
              Image(image: AssetImage("assets/splash.png") ,width: 220,height: 200,),
            ],
          )

      ),
    );
  }
}