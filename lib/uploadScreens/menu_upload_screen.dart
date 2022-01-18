import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/mainScreens/home_screen.dart';
import 'package:sellers_app/widgets/error_dialog.dart';
import 'package:sellers_app/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart'as storageRef;

class MenuUploadScreen extends StatefulWidget {

  const MenuUploadScreen({Key? key}): super(key:key);

  @override
  _MenuUploadScreenState createState() => _MenuUploadScreenState();
}



class _MenuUploadScreenState extends State<MenuUploadScreen> {

  XFile? imageXFile;
  final ImagePicker _picker=ImagePicker();

  TextEditingController shortInfoController=TextEditingController();
  TextEditingController titleController=TextEditingController();

bool uploading=false;
String uniqueIdName=DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen()
  {
    return Scaffold(
      appBar: AppBar(
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
        title:const Text(
          "Dodaj Novi Meni",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color:Colors.white),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
          },
        ),

      ),
      body: Container(
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
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(Icons.shop_two,color: Colors.white,size:200.0,),
            ElevatedButton(
                onPressed: (){
takeImage(context);
                },
                child: const Text(
                  "Dodaj novi meni",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }

  takeImage(mContext){
    return showDialog(
      context: mContext,
      builder: (context){
        return SimpleDialog(
          title: Text(
            "Slika menija",
            style: TextStyle(color:Colors.cyan,fontWeight: FontWeight.bold),

          ),
          children: [
SimpleDialogOption(
  child: const Text(
      "Slikaj kamerom",
      style:TextStyle(color:Colors.grey),
  ),
  onPressed: captureImageWithCamera,
),
            SimpleDialogOption(
              child: const Text(
                "Izaberi iz galerije",
                style:TextStyle(color:Colors.grey),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: const Text(
                "Otkazati",
                style:TextStyle(color:Colors.redAccent),
              ),
              onPressed: ()=>Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera()async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });

  }

  pickImageFromGallery()async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  menusUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
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
        title:const Text(
          "Dodavanje Novog Menija",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color:Colors.white),
          onPressed: (){
            clearMenusUploadForm();          },
        ),
        actions: [
          TextButton(
            child: const Text(
              "+ Dodaj",
              style: TextStyle(color: Colors.white70,
                  fontWeight:FontWeight.bold,
                  fontSize: 15,
                fontFamily: "Varela",
                letterSpacing: 1,
              ),
            ),
            onPressed: uploading ? null :()=> validateUploadForm(),
          ),
        ],

      ),
      body:ListView(
        children: [
      uploading==true ? linearProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child:Center(
              child:AspectRatio(
                  aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image:FileImage(
                          File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information,color:Colors.cyan),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color:Colors.black),
                controller: shortInfoController,
                decoration: InputDecoration(
                  hintText: "Informacije o meniju",
                  hintStyle: TextStyle(color:Colors.grey),
                  border:InputBorder.none,
                ),
              ) ,
            ),
          ),

          const Divider(
            color: Colors.cyan,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.title,color:Colors.cyan),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color:Colors.black),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Naziv menija",
                  hintStyle: TextStyle(color:Colors.grey),
                  border:InputBorder.none,
                ),
              ) ,
            ),
          ),
          const Divider(
            color: Colors.cyan,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  clearMenusUploadForm(){
setState(() {
  shortInfoController.clear();
  titleController.clear();
  imageXFile=null;
});
  }

  validateUploadForm()async{

    if(imageXFile !=null)
      {
if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty )
  {
    setState(() {
      uploading=true;
    });
    //upload image
    String downloadUrl=await uploadImage(File(imageXFile!.path));
    //save info to firestore
    saveInfo(downloadUrl);
  }else {
  showDialog(
      context: context,
      builder: (c){
        return ErrorDialog(
          message: "Molimo vas unesite naziv i informacije menija",
        );
      }
  );
  }
      }else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Molimo vas izaberite sliku za meni",
            );
          }
      );
    }
  }

  uploadImage(mImageFile)async{
storageRef.Reference reference= storageRef.FirebaseStorage
    .instance
    .ref()
    .child("menus");

storageRef.UploadTask uploadTask = reference
    .child(uniqueIdName+".jpg")
    .putFile(mImageFile);

storageRef.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});

String downloadUrl=await taskSnapshot.ref.getDownloadURL();

  return downloadUrl;
  }

  saveInfo(String downloadUrl)
  {
    final ref=FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID":uniqueIdName,
      "sellerUID":sharedPreferences!.getString("uid"),
      "menuInfo":shortInfoController.text.toString(),
      "menuTitle":titleController.text.toString(),
      "publishedDate":DateTime.now(),
      "status":"available",
      "thumbnailUrl":downloadUrl,
    });

    clearMenusUploadForm();
    setState(() {
      uniqueIdName=DateTime.now().millisecondsSinceEpoch.toString();
      uploading=false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return imageXFile==null ? defaultScreen() : menusUploadFormScreen();
  }
}
