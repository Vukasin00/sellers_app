import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/assistantMethods/assistant_methods.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/widgets/order_cart.dart';
import 'package:sellers_app/widgets/progress_bar.dart';
import 'package:sellers_app/widgets/simple_app_bar.dart';


class OrdersHistoryScreen extends StatefulWidget {
  @override
  _OrdersHistoryScreenState createState() => _OrdersHistoryScreenState();
}



class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "Istorija porudzbina",),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status",isEqualTo: "ended")
              .where("sellerUID",isEqualTo:sharedPreferences!.getString("uid") )
              .orderBy("orderTime",descending: true)
              .snapshots(),

          builder: (c,snapshot){
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c,index){
                return FutureBuilder<QuerySnapshot>(
                  future:FirebaseFirestore
                      .instance.collection("items")
                      .where("itemID",whereIn: seperateOrderItemIDs((snapshot.data!.docs[index].data()!as Map<String, dynamic>)["productIDs"] ))
                      .orderBy("publishedDate",descending: true)
                      .get(),
                  builder: (c,snap){
                    return snap.hasData
                        ? OrderCard(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      seperateQuantitiesList: seperateOrderItemQuantities((snapshot.data!.docs[index].data()!as Map<String, dynamic>)["productIDs"] ),
                    )
                        : Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}
