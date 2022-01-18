import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sellers_app/assistantMethods/cart_item_counter.dart';
import 'package:sellers_app/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';




seperateOrderItemIDs(orderIDs){
  List<String> separateItemIdsList=[],defaultItemList=[];
  int i=0;
  defaultItemList= List<String>.from(orderIDs) ;
  for(i;i<defaultItemList.length;i++)
  {
    String item=defaultItemList[i].toString();
    var pos=item.lastIndexOf(":");
    String getItemId = (pos!=-1) ? item.substring(0,pos): item;

    separateItemIdsList.add(getItemId);

  }

  return(separateItemIdsList);


}

seperateItemIDs(){
  List<String> separateItemIdsList=[],defaultItemList=[];
  int i=0;
  defaultItemList=sharedPreferences!.getStringList("userCart")!;
  for(i;i<defaultItemList.length;i++)
  {
    String item=defaultItemList[i].toString();
    var pos=item.lastIndexOf(":");
    String getItemId = (pos!=-1) ? item.substring(0,pos): item;

    separateItemIdsList.add(getItemId);

  }

  return(separateItemIdsList);


}

addItemToCart(String? foodItemId,BuildContext context,int itemCounter){
  List<String>? tempList=sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //npr 21531:7

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart":tempList,
  }).then((value){
    Fluttertoast.showToast(msg: "Stavka je uspješno dodata.");

    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context,listen:false).displayCartListItemsNumber();
  });

}


seperateOrderItemQuantities(orderIDs){
  List<String>defaultItemList=[];
  List<String>separateItemQuantityList=[];
  int i=1;
  defaultItemList=List<String>.from(orderIDs);
  for(i;i<defaultItemList.length;i++)
  {
    String item=defaultItemList[i].toString();

    List<String> listItemCharacters=item.split(":").toList();

    var quanNumber=int.parse(listItemCharacters[1].toString());

    print("\nThis is QN = "+quanNumber.toString());

    separateItemQuantityList.add(quanNumber.toString());

  }

  return(separateItemQuantityList);


}

seperateItemQuantities(){
  List<String>defaultItemList=[];
  List<int>separateItemQuantityList=[];
  int i=1;
  defaultItemList=sharedPreferences!.getStringList("userCart")!;
  for(i;i<defaultItemList.length;i++)
  {
    String item=defaultItemList[i].toString();

    List<String> listItemCharacters=item.split(":").toList();

    var quanNumber=int.parse(listItemCharacters[1].toString());

    print("\nThis is QN = "+quanNumber.toString());

    separateItemQuantityList.add(quanNumber);

  }

  return(separateItemQuantityList);


}

clearCartNow(context){
  sharedPreferences!.setStringList("userCart", ['garbageValue']);

  List<String>? emptyList = sharedPreferences!.getStringList('userCart');

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart":emptyList}).then((value) {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context,listen: false).displayCartListItemsNumber();
  });
}
