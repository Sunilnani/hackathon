import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Dio dio = new Dio();
  var data= "";
  dynamic res ;
  dynamic respo;
  Products createcatg= Products();
  final TextController = TextEditingController();
  final descriptionContoller = TextEditingController();
  final priceCotroller = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  final idcontroller = TextEditingController();
  final numberController=TextEditingController();
  final nameController=TextEditingController();
  final categoryidController= TextEditingController();



  File img ;
  void productsadd()async{
    String  text = TextController.text.trim();
    String  desc = descriptionContoller.text.trim();
    String  price = priceCotroller.text.trim();
    String  category = categoryIdcontoller.text.trim();
    try{
      FormData formData = FormData.fromMap({
        "name" : text,
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
        res=response.statusMessage;
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
  void cameraClick ()  async{
    File image;
    var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imagePicker != null){
      setState(() {
        image=imagePicker;
        img = imagePicker;
      });
    }
  }
  void addcategory() async {
    String  text = TextController.text.trim();
    String  desc = descriptionContoller.text.trim();
    String  price = priceCotroller.text.trim();
    String  category = categoryIdcontoller.text.trim();

    // File image;
    // var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);

    try {

      FormData formData = FormData.fromMap({
        "name" : text,
        "image":"null"

      });
      Response response =
      await Dio().post("http://sowmyamatsa.pythonanywhere.com/category/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data));

        print(response.data);
        res=response.statusMessage;
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
        createcatg = productsFromJson(jsonEncode(response.data));

        print(response.data);
        res=response.statusMessage;
      });
    }
    catch(e){

    }
  }
  //
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
        respo=response.statusMessage;
      });
    } catch (e) {
      setState(() {
        print("error ---> $e");
      });
      print(e);
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
                              child: Text("click to Add"),
                              onPressed: (){
                                addcategory();
                                setState(() {

                                });
                              }),
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
                        ],
                      ),
                    ),
                    // respo == null ?Text("no data")  :    Text("test --- ${respo}"),



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
                              controller: TextController,
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