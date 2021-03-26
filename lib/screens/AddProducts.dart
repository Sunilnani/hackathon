import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/patch_model.dart';
import 'package:e_commerce/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Dio dio = new Dio();
  File datas;
  dynamic res ;
  dynamic respo;
  dynamic responses;
  dynamic patchresponse;
  Category category=Category();
  Products createcatg= Products();
  Patchcategory patchcatg=Patchcategory();
  final TextController = TextEditingController();
  final productnameController=TextEditingController();
  final descriptionContoller = TextEditingController();
  final priceCotroller = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  final idcontroller = TextEditingController();
  final numberController=TextEditingController();
  final nameController=TextEditingController();
  final categoryidController= TextEditingController();
  final patch_product_idController= TextEditingController();
  final patch_product_nameController=TextEditingController();
  final patch_priceController=TextEditingController();
  final patch_category_idController= TextEditingController();



  File img ;
  void productsadd()async{
    String  productname = productnameController.text.trim();
    String  desc = descriptionContoller.text.trim();
    String  price = priceCotroller.text.trim();
    String  category = categoryIdcontoller.text.trim();
    try{
      FormData formData = FormData.fromMap({
        "name" : productname,
        "description":desc,
        "price":price,
        "category_id":category,
        "image":"null"
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
  void deleteproducts() async {
    String  id = numberController.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "product_id" : id
      });
      Response response =
      await Dio().delete("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data));
        print(response.data["message"]);
        respo=response.statusMessage;
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
    }
  }



  // Future addcategory ()async{
  //   File _image;
  //   final picker= ImagePicker();
  //   var pickfile=await picker.getImage(source: ImageSource.gallery);
  //   _image=pickfile.path as File;
  //   _upload(_image);
  // }

  void cameraClick ()  async{
    File _image;
    var galary =await ImagePicker.pickImage(source: ImageSource.gallery);
    if (galary != null){
      setState(() {
        _image=galary;
        img=galary;
        print(img.path);
      });
    }
  }
  void addcategory()async{
    String  text = TextController.text.trim();
    // String filename=file.path.split("/").last;
    FormData data = FormData.fromMap({
      "name":text,
      "image":await MultipartFile.fromFile(img.path)
    });
    Response response =
    await Dio().post("http://sowmyamatsa.pythonanywhere.com/category/" , data: data);
    setState(() {
      category = categoryFromJson(jsonEncode(response.data)) ;

      print(response.data);
      res=response.statusMessage;
      print(response);
    });
  }
  // void addcategory() async {
  //   String  text = TextController.text.trim();
  //   try {
  //
  //     FormData formData = FormData.fromMap({
  //       "name" : text,
  //       "image":"null"
  //
  //     });
  //     Response response =
  //     await Dio().post("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
  //     setState(() {
  //       category = categoryFromJson(jsonEncode(response.data)) ;
  //
  //       print(response.data);
  //       res=response.statusMessage;
  //       print(response);
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print("error ---> $e");
  //     });
  //     print(e);
  //   }
  // }
  void deletecategory() async {
    String  number = idcontroller.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "category_id" : number
      });
      Response response =
      await Dio().delete("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data));
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
        "category_id":categoryid
      });
      Response response =
      await Dio().patch("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
      setState(() {
        patchcatg = patchcategoryFromJson(jsonEncode(response.data));

        print(response.data);
        patchresponse=response.data["m"];
      });
    }
    catch(e){

    }
  }
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
  void initState() {
    deletecategory();
    productsadd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: ()async{
        // ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/background.jpg"),fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        color: Colors.tealAccent[100]
                      ),
                      child: Column(
                        children: [
                          Text("To Add The Categories",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700)),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: TextController,
                              decoration: InputDecoration(
                                  hintText: "Enter name"
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("upload"),
                              onPressed: (){
                                setState(() {
                                  cameraClick();
                                });
                              }),
                          RaisedButton(
                              child: Text("Submit"),
                              onPressed: (){
                                addcategory();
                                setState(() {

                                });
                              }),
                          res == null ? Text("no data")  :    Text("test --- ${res}"),
                          // Center(
                          //   child: RaisedButton(
                          //     child: Text('click Image'),
                          //     onPressed: (){
                          //       cameraClick();
                          //       Create();
                          //       setState(() {
                          //
                          //       });
                          //     },
                          //   ),
                          // ),
                          SizedBox(height: 30,),
                          Text("To Delete The Categories",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: idcontroller,
                              decoration: InputDecoration(
                                  hintText: "Enter id "
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("click to delete"),
                              onPressed: (){
                                deletecategory();
                                setState(() {

                                });
                              }),
                          respo == null ?Text("enter valid id") :Text("test --- ${respo}"),
                        ],
                      ),
                    ),




                    SizedBox(height: 30,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.amber[100]),
                      child: Column(
                        children: [
                          Text("To Add and Delete Products",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
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
                              controller: categoryIdcontoller,
                              decoration: InputDecoration(
                                  hintText: "Category id"
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("Click To Add"),
                              onPressed: (){
                                productsadd();
                                setState(() {

                                });
                              }),
                          responses==null ?Text("enter valid details"):Text(responses),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: numberController,
                              decoration: InputDecoration(
                                  hintText: "Enter product id "
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("Click to Delete"),
                              onPressed: (){
                                deleteproducts();
                                setState(() {

                                });
                              }),
                        ],
                      ),
                    ),

                    SizedBox(height:30,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.pinkAccent[100],),

                      child: Column(
                        children: [
                          Text("Patch Category",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: "Enter Category Name"
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: categoryidController,
                              decoration: InputDecoration(
                                  hintText: "Enter category id"
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("click to update"),
                              onPressed: (){
                                patchcategory();
                                setState(() {

                                });
                              }),
                          patchresponse==null?Text("enter valid id"):Text(patchresponse),



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
                              child: Text("Click To Add"),
                              onPressed: (){
                                patchproduct();
                                setState(() {

                                });
                              }),
                        ],
                      ),
                    )

                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}