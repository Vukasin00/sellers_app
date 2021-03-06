import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/authentification/auth_screen.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/mainScreens/home_screen.dart';
import 'package:sellers_app/mainScreens/new_orders_screen.dart';
import 'package:sellers_app/mainScreens/order_history_screen.dart';


class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children:[
          //header drawer
          Container(
            padding:const EdgeInsets.only(top:25,bottom:10),
            child:Column(
              children:[
                //header drawer
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation:10,
                  child:Padding(
                    padding:const EdgeInsets.all(1.0),
                    child:Container(
                      height: 160,
                      width: 160,
                      child:CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      )
                    )
                  )
                ),
                const SizedBox(height: 10,),
                Text(sharedPreferences!.getString("name")!,
                style:const TextStyle(color: Colors.black, fontSize: 20, fontFamily:"Kiwi" )
                ),
              ]
            )
          ),

          const SizedBox(height: 12,),
          //body drawer
          Container(
            padding:  const EdgeInsets.only(top:1.0),
            child: Column(
              children:[
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),
                ListTile(
                 leading: const Icon(Icons.home,color:Colors.black,),
                 title:const Text(
                   "Po??etna",
                 style: TextStyle(color: Colors.black),
    ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(c)=> const HomeScreen()));

             },
    ),
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),

               /* ListTile(
                  leading: const Icon(Icons.monetization_on,color:Colors.black,),
                  title:const Text(
                    "Moja zarada",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){

                  },
                ),
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),*/
                ListTile(
                  leading: const Icon(Icons.reorder,color:Colors.black,),
                  title:const Text(
                    "Nove narud??bine",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>NewOrdersScreen()));
                  },
                ),
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping,color:Colors.black,),
                  title:const Text(
                    "Istorija Narud??bina",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>OrdersHistoryScreen()));
                  },
                ),
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app,color:Colors.black,),
                  title:const Text(
                    "Odjava",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: (){
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(context, MaterialPageRoute(builder:(c)=> const AuthScreen()));
                    });
                  },
                ),
                const Divider(
                  height:10,
                  color:Colors.grey,
                  thickness:2,
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}
