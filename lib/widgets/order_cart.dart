import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/mainScreens/order_details_screen.dart';
import 'package:sellers_app/model/Items.dart';


class OrderCard extends StatelessWidget {

  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (c)=>OrderDetailScreen(orderID:orderID)));
      },
      child:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Colors.black12,
              Colors.white54,
            ],
            begin: FractionalOffset(0.0,0.0),
            end:FractionalOffset(1.0, 0.0),
            stops:[0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: EdgeInsets.all(10),
        margin:const EdgeInsets.all(10),
        height: itemCount! * 125,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            Items model=Items.fromJson(data![index].data()! as Map<String,dynamic>) ;
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}



Widget placedOrderDesignWidget(Items model, BuildContext context,seperateQuantitiesList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey[200],
    child: Row(
      children: [
        Column(
          children: [
            Image.network(model.thumbnailUrl!,width: 100,height: 100,),
            SizedBox(height: 10,),
          ],
        ),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(
                    model.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Acme",
                    ),
                  ),),
                  SizedBox(width: 10,),
                  const Text(
                    "Din ",
                    style: TextStyle( fontSize: 16.0,color:Colors.green,fontWeight: FontWeight.bold,),

                  ),
                  Text(
                  model.price.toString(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  const Text(
                    "x ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                        fontFamily: "Acme",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),

  );
}