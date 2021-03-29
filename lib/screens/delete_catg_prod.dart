import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/delete_model.dart';
import 'package:flutter/material.dart';
class Delete_catg_prod extends StatefulWidget {
  Delete_catg_prod({this.productid,});
  final int productid;
  @override
  _Delete_catg_prodState createState() => _Delete_catg_prodState();
}

class _Delete_catg_prodState extends State<Delete_catg_prod> {
  dynamic respo;
  dynamic prodres;
  Delete createcatg= Delete();
  Products deleteprod= Products();
  final idcontroller = TextEditingController();
  final numberController=TextEditingController();
  // void deletecategory() async {
  //   String  number = idcontroller.text.trim();
  //   try {
  //     FormData formData = FormData.fromMap({
  //       "category_id" : number
  //     });
  //     Response response =
  //     await Dio().delete("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
  //     setState(() {
  //       createcatg = deleteFromJson(jsonEncode(response.data));
  //       print(response.data["message"]);
  //       respo=response.data["message"];
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print("error ---> $e");
  //     });
  //     print(e);
  //   }
  // }


  void deleteproducts() async {
    String  id = numberController.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "product_id" :widget.productid
      });
      Response response =
      await Dio().delete("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        deleteprod = productsFromJson(jsonEncode(response.data));
        print(response.data["message"]);
        prodres=response.statusMessage;
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Text("Category",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16),),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: idcontroller,
                  //     decoration: InputDecoration(
                  //         hintText: "Enter id "
                  //     ),
                  //   ),
                  // ),
                  // RaisedButton(
                  //     child: Text("click to delete"),
                  //     onPressed: (){
                  //       deletecategory();
                  //       setState(() {
                  //
                  //       });
                  //     }),
                  // respo == null ?Text("enter valid id") :Text("test --- ${respo}"),
                  RaisedButton(
                      child: Text("Click to Delete"),
                      onPressed: (){
                        deleteproducts();
                        setState(() {

                        });
                      }),
                  prodres == null ?Text("enter valid id") :Text("test --- ${prodres}"),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
