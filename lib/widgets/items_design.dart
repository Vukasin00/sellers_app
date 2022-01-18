import 'package:flutter/material.dart';
import 'package:sellers_app/mainScreens/itemsScreen.dart';
import 'package:sellers_app/model/Items.dart';
import 'package:sellers_app/model/Menus.dart';


class ItemsDesignWidget extends StatefulWidget {

  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model,this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
         // Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model:widget.model)));
        },
        splashColor: Colors.redAccent,
        child:Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Divider(
                  height: 4,
                  thickness: 3,
                  color: Colors.grey[300],

                ),
                const SizedBox(height: 1.0,),
                Text(
                  widget.model!.title!,
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontFamily:"Kiwi",
                  ),
                ),
                const SizedBox(height: 2.0,),
                Image.network(
                  widget.model!.thumbnailUrl!,
                  height:210,
                  width:  MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 1.0,),
                Text(
                  widget.model!.shortInfo!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily:"Kiwi",
                  ),
                ),
                const SizedBox(height: 1.0,),
                Divider(
                  height: 4,
                  thickness: 3,
                  color: Colors.grey[300],

                ),
              ],
            ),
          ),
        )
    );
  }
}
