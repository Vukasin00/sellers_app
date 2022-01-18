import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/mainScreens/home_screen.dart';

class StatusBanner extends StatelessWidget {

  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status,this.orderStatus});

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData=Icons.done : iconData=Icons.cancel;
    status! ? message="Uspješno" : message="Neuspješno";


    return Container(
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
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            orderStatus =="ended"? "Porudžbina isporučena - $message"
                : "Porudžbina naručena - $message ",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 5,),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
