import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/delete_model.dart';
import 'package:e_commerce/models/patch_model.dart';
import 'package:e_commerce/screens/homepage.dart';
import 'package:flutter/material.dart';
class Delete_catg_prod extends StatefulWidget {
  Delete_catg_prod({this.productid,this.categoryid});
  final int productid;
  final int categoryid;
  @override
  _Delete_catg_prodState createState() => _Delete_catg_prodState();
}

class _Delete_catg_prodState extends State<Delete_catg_prod> {
  dynamic respo;
  dynamic prodres;
  dynamic patchresponse;
  Delete createcatg= Delete();
  Patchcategory patchcatg=Patchcategory();
  final idcontroller = TextEditingController();
  final numberController=TextEditingController();
  final nameController=TextEditingController();
  final categoryidController= TextEditingController();
  void deletecategory() async {
    String  number = idcontroller.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "category_id" : widget.categoryid
      });
      Response response =
      await Dio().delete("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
      setState(() {
        createcatg = deleteFromJson(jsonEncode(response.data));
        print(response.data["message"]);
        respo=response.data["message"];
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }
  void patchcategory()async{
      String  text = nameController.text.trim();
      String categoryid = categoryidController.text.trim();
      try{
        FormData formData = FormData.fromMap({
          "name" : text,
          "category_id":widget.categoryid
        });
        Response response =
        await Dio().patch("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
        setState(() {
          patchcatg = patchcategoryFromJson(jsonEncode(response.data));

          print(response.data);
          patchresponse=response.data["message"];
        });
      }
      catch(e){

      }
    }


  // void deleteproducts() async {
  //   String  id = numberController.text.trim();
  //   try {
  //     FormData formData = FormData.fromMap({
  //       "product_id" :widget.productid
  //     });
  //     Response response =
  //     await Dio().delete("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
  //     setState(() {
  //       deleteprod = productsFromJson(jsonEncode(response.data));
  //       print(response.data["message"]);
  //       prodres=response.statusMessage;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print("error ---> $e");
  //     });
  //     print(e);
  //   }
  // }
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
                  Text("Category Update",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16),),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: idcontroller,
                  //     decoration: InputDecoration(
                  //         hintText: "Enter id "
                  //     ),
                  //   ),
                  // ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Enter Category Name"
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: TextField(
                //     controller: categoryidController,
                //     decoration: InputDecoration(
                //         hintText: "Enter category id"
                //     ),
                //   ),
                // ),
                  Text("${widget.categoryid}"),
                RaisedButton(
                    child: Text("click to update"),
                    onPressed: (){
                      patchcategory();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>HomePage(

                          ),
                        ),
                      );
                      setState(() {

                      });
                    }),
                patchresponse==null?Text("enter valid id"):Text(patchresponse),
                  SizedBox(height: 30,),

                  Text("Category Delete",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 16),),
                  RaisedButton(
                      child: Text("click to delete"),
                      onPressed: (){
                        deletecategory();
                        Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>HomePage(

                                ),
                              ),
                            );
                        setState(() {

                        });
                      }),
                  respo == null ?Text("") :Text("test --- ${respo}"),
                  // RaisedButton(
                  //     child: Text("Click to Delete"),
                  //     onPressed: (){
                  //       deleteproducts();
                  //       setState(() {
                  //
                  //       });
                  //     }),
                  // prodres == null ?Text("enter valid id") :Text("test --- ${prodres}"),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
