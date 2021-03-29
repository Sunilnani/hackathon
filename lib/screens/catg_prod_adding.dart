import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/data_model.dart';
import 'package:e_commerce/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Add_catg_prod extends StatefulWidget {
  Add_catg_prod({this.categoryid,this.getproduct});
  final int categoryid;
  Product getproduct=Product();
  @override
  _Add_catg_prodState createState() => _Add_catg_prodState();
}

class _Add_catg_prodState extends State<Add_catg_prod> {
  dynamic res ;
  dynamic responses;
  Category category=Category();
  Products createcatg= Products();
  final TextController = TextEditingController();
  final productnameController=TextEditingController();
  final descriptionContoller = TextEditingController();
  final priceCotroller = TextEditingController();
  final caloryCotroller = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  File img;
  File productimag ;
  // void cameraClick ()  async{
  //   File _image;
  //   var galary =await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (galary != null){
  //     setState(() {
  //       _image=galary;
  //       img=galary;
  //       print(img.path);
  //     });
  //   }
  // }
  // void addcategory()async{
  //   String  text = TextController.text.trim();
  //   // String filename=file.path.split("/").last;
  //   FormData data = FormData.fromMap({
  //     "name":text,
  //     "image":await MultipartFile.fromFile(img.path)
  //   });
  //   Response response =
  //   await Dio().post("http://sowmyamatsa.pythonanywhere.com/category/" , data: data);
  //   setState(() {
  //     category = categoryFromJson(jsonEncode(response.data)) ;
  //
  //     print(response.data);
  //     res=response.statusMessage;
  //     print(response);
  //   });
  // }
  void productcameraClick ()  async{
    File _image;
    var galary =await ImagePicker.pickImage(source: ImageSource.gallery);
    if (galary != null){
      setState(() {
        _image=galary;
        productimag=galary;
        print(productimag.path);
      });
    }
  }
  void productsadd()async{
    String  productname = productnameController.text.trim();
    String  desc = descriptionContoller.text.trim();
    String  price = priceCotroller.text.trim();
    String calory = caloryCotroller.text.trim();
    String  category = categoryIdcontoller.text.trim();
    try{
      FormData formData = FormData.fromMap({
        "name" : productname,
        "description":desc,
        "price":price,
        "category_id":widget.categoryid,
        "calories":calory,
        "image":await MultipartFile.fromFile(productimag.path)
      });
      Response response =
      await Dio().post("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data));
        print(response.data);
        responses=response.data["message"];
      });
    }
    catch(e){

    }
  }
  void initState() {
    // deletecategory();
    productsadd();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Text("Category",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16),),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: TextController,
                  //     decoration: InputDecoration(
                  //         hintText: "Enter name"
                  //     ),
                  //   ),
                  // ),
                  // RaisedButton(
                  //     child: Text("upload"),
                  //     onPressed: (){
                  //       setState(() {
                  //         cameraClick();
                  //       });
                  //     }),
                  // RaisedButton(
                  //     child: Text("Submit"),
                  //     onPressed: (){
                  //       addcategory();
                  //       setState(() {
                  //
                  //       });
                  //     }),
                  // res == null ? Text("no data")  :    Text("test --- ${res}"),

                  SizedBox(height: 50,),
                  Text("Products",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: productnameController,
                      decoration: InputDecoration(
                          hintText: "Enter Name"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: descriptionContoller,
                      decoration: InputDecoration(
                          hintText: "Enter Description"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: priceCotroller,
                      decoration: InputDecoration(
                          hintText: "Enter Price"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: caloryCotroller,
                      decoration: InputDecoration(
                          hintText: "Enter calories"
                      ),
                    ),
                  ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: categoryIdcontoller,
                  //     decoration: InputDecoration(
                  //         hintText: "Category id"
                  //     ),
                  //   ),
                  // ),
                  Text("${widget.categoryid}"),
                  RaisedButton(
                      child: Text("upload"),
                      onPressed: (){
                        setState(() {
                          productcameraClick();
                        });
                      }),
                  RaisedButton(
                      child: Text("Click To Add"),
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>Add_catg_prod(
                            ),
                          ),
                        );
                        productsadd();
                        setState(() {

                        });
                      }),
                  responses==null ?Text("enter valid details"):Text(responses),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
