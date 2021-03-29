import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/patch_model.dart';
import 'package:flutter/material.dart';
class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  dynamic patchresponse;
  dynamic res;
  Products createcatg= Products();
  Patchcategory patchcatg=Patchcategory();
  final nameController=TextEditingController();
  final categoryidController= TextEditingController();
  final patch_product_idController= TextEditingController();
  final patch_product_nameController=TextEditingController();
  final patch_priceController=TextEditingController();
  final patch_category_idController= TextEditingController();



  // void patchcategory()async{
  //   String  text = nameController.text.trim();
  //   String categoryid = categoryidController.text.trim();
  //   try{
  //     FormData formData = FormData.fromMap({
  //       "name" : text,
  //       "category_id":categoryid
  //     });
  //     Response response =
  //     await Dio().patch("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
  //     setState(() {
  //       patchcatg = patchcategoryFromJson(jsonEncode(response.data));
  //
  //       print(response.data);
  //       patchresponse=response.data["message"];
  //     });
  //   }
  //   catch(e){
  //
  //   }
  // }

  void patchproduct()async{
    String  product_id = patch_product_idController.text.trim();
    String patch_name = patch_product_nameController.text.trim();
    String patch_prise = patch_priceController.text.trim();
    String category_id = patch_category_idController.text.trim();
    try{
      FormData formData = FormData.fromMap({
        "product_id" : product_id,
        "name":patch_name,
        "price":patch_prise,
        "category_id":category_id
      });
      Response response =
      await Dio().patch("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data));
        print(response.data);
        res=response.data["message"];
      });
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Text("Patch",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: nameController,
                  //     decoration: InputDecoration(
                  //         hintText: "Enter Category Name"
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: TextField(
                  //     controller: categoryidController,
                  //     decoration: InputDecoration(
                  //         hintText: "Enter category id"
                  //     ),
                  //   ),
                  // ),
                  // RaisedButton(
                  //     child: Text("click to update"),
                  //     onPressed: (){
                  //       patchcategory();
                  //       setState(() {
                  //
                  //       });
                  //     }),
                  // patchresponse==null?Text("enter valid id"):Text(patchresponse),
                  SizedBox(height: 50,),
                  Text("Patch_Product",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w700),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: patch_product_idController,
                      decoration: InputDecoration(
                          hintText: "Enter product_id"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: patch_product_nameController,
                      decoration: InputDecoration(
                          hintText: "Enter Product Name"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: patch_priceController,
                      decoration: InputDecoration(
                          hintText: "Enter Price"
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: patch_category_idController,
                      decoration: InputDecoration(
                          hintText: "Category id"
                      ),
                    ),
                  ),
                  RaisedButton(
                      child: Text("Click To update"),
                      onPressed: (){
                        patchproduct();
                        setState(() {

                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
