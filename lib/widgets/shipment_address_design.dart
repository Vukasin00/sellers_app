import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/model/address.dart';


class ShipmentAddressDesign extends StatelessWidget {

  final Address? model;

  ShipmentAddressDesign({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.all(10.0),
          child:  Text(
            'Detalji isporuke: ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const  SizedBox(height: 6.0,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const   Text(
                    "Ime:",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  Text(model!.name.toString()),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Telefon:",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  Text(model!.phoneNumber.toString()),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        Center(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (c)=>const MySplashScreen()));
                },
                child: Container(
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
                  width: MediaQuery.of(context).size.width-40.0,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: Text(
                        "Idi nazad",
                        style:TextStyle(
                            color: Colors.white,fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
