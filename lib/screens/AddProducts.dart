import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Dio dio = new Dio();
  var data= "";
  Getpost createcatg= Getpost();
  TextEditingController TextController = TextEditingController();
  void Create() async {
    String  text = TextController.text.trim();
    File image;
    var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imagePicker != null){
      setState(() {
        image=imagePicker;
      });
    }
    try {
      String filename= image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name" : text,
        "imageUrl":
        await MultipartFile.fromFile(image.path,filename: filename,
            contentType: MediaType('imageUrl','png')
        ),

      });
      Response response =
      await Dio().post("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
      setState(() {
        createcatg = getpostFromJson(jsonEncode(response.data));

        print(response.data);
        data=response.statusMessage;
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  // void Createone() async{
  //   File image;
  //       var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
  //       if(imagePicker != null){
  //         setState(() {
  //           image=imagePicker;
  //         });
  //       }
  //       try{
  //         String filename= image.path.split('/').last;
  //         FormData formData=new FormData.fromMap({
  //           "imageUrl":
  //          await MultipartFile.fromFile(image.path,filename: filename,
  //            contentType: MediaType('imageUrl','png')
  //          ),
  //           // "type":"image/png"
  //
  //         });
  //         Response response = await dio.post("http://sowmyamatsa.pythonanywhere.com/category/",data: formData);
  //         setState(() {
  //           createcatg = getpostFromJson(jsonEncode(response.data));
  //
  //           print(response.data);
  //         });
  //       }
  //       catch(e){
  //         print(e);
  //       }
  // }
  // void delete()async{
  //   String id = TextController.text.trim();
  //   try{
  //     Response response;
  //     Dio dio = new Dio();
  //     response = await dio.delete("http://sowmyamatsa.pythonanywhere.com/category?id=$id");
  //     print(response.data.toString());
  //   }
  //   catch (e){
  //     setState(() {
  //       print(e);
  //     });
  //   }
  // }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //     File image;
    //     var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    //     if(imagePicker != null){
    //       setState(() {
    //         image=imagePicker;
    //       });
    //     }
    //     try{
    //       String filename= image.path.split('/').last;
    //       FormData formData=new FormData.fromMap({
    //         "image":
    //        await MultipartFile.fromFile(image.path,filename: filename,
    //          contentType: MediaType('image','png')
    //        ),
    //         "type":"image/png"
    //
    //       });
    //       Response response = await dio.post("http://sowmyamatsa.pythonanywhere.com/category/",data: formData,options: Options(
    //         headers: {
    //           "accept":"*/*",
    //           "Authorization":"Bearer accesstoken",
    //           "content-type":"multipart/form-data"
    //         }
    //       ));
    //     }
    //     catch(e){
    //       print(e);
    //     }
    //   },
    return MaterialApp(
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async{
        // ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                  onChanged: (text) {
                    print("First text field: $text");
                    },
                   ),
                ),
                RaisedButton(
                  child: Text("upload image"),
                    onPressed: (){
                    Create();
                    }),
                Center(
                  child: RaisedButton(
                    child: Text('Press Here'),
                    onPressed: (){
                      setState(() {
                        print(data);
                        Create();
                      });
                    },
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: TextField(
                //     onChanged: (id) {
                //       print("delete id: $id");
                //     },
                //   ),
                // ),
                // Center(
                //   child: RaisedButton(
                //     child: Text('delete Here'),
                //     onPressed: (){
                //       setState(() {
                //         print("'successful");
                //         delete();
                //       });
                //     },
                //   ),
                // ),

              ],
            )
          ),
        ),
      ),
    );
  }
}
