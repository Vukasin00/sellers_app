import 'package:flutter/material.dart';
import 'package:sellers_app/authentification/register.dart';

import 'login.dart';
    
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}): super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
     length:2,
     child:Scaffold(
       appBar:AppBar(
         flexibleSpace: Container(
           decoration: const BoxDecoration(
           gradient: LinearGradient(
             colors:[
               Colors.cyan,
               Colors.redAccent,
             ],
             begin: FractionalOffset(0.0,0.0),
             end:FractionalOffset(1.0, 0.0),
             stops:[0.0,1.0],
             tileMode: TileMode.clamp,
           ),
         ),
         ),
        automaticallyImplyLeading:false ,
        title: const Text(
          "Gurman",
          style: TextStyle(
            fontSize: 60,
            color:Colors.white,
            fontFamily:"Lobster",
          ),
        ),
         centerTitle: true,
         bottom: const TabBar(
           tabs:[
             Tab(
               icon:Icon(Icons.lock,color:Colors.white),
               text:"Prijava",
             ),
             Tab(
               icon:Icon(Icons.person,color:Colors.white),
               text:"Registracija",
             ),
           ],
           indicatorColor:Colors.white38,
           indicatorWeight: 6,
         ),
       ),
       body: Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             begin:Alignment.topRight,
             end:Alignment.bottomLeft,
             colors:[
               Colors.redAccent,
               Colors.cyan,
             ]
           )
         ),
         child: const TabBarView(
           children:[
             LoginScreen(),
             RegisterScreen(),
           ]
         )
       ),
     ),
   );
  }
}
    