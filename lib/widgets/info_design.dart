import 'package:flutter/material.dart';
import 'package:sellers_app/mainScreens/itemsScreen.dart';
import 'package:sellers_app/model/Menus.dart';


class InfoDesignWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model,this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model:widget.model)));
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
              Image.network(
                  widget.model!.thumbnailUrl!,
                      height:210,
                width:  MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 23,
                  fontFamily:"Kiwi",
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily:"Kiwi",
                ),
              ),
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
