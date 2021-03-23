import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/data_model.dart';
import 'package:flutter/material.dart';

import 'details.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String petcategory="";
  String indx="";
  List<Product> list=List();
  bool _loading = false;
  ProductElement products=ProductElement();
  void getHttp() async {
    setState(() {

    });
    try {
      Response response =
      await Dio().get("http://sowmyamatsa.pythonanywhere.com/categories_details/");
      setState(() {
        list = productFromJson(jsonEncode(response.data));
        _loading=true;
      });

    } catch (e) {
      setState(() {
        _loading = true;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.pinkAccent,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      decoration: BoxDecoration(

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hey Customer",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),),
                                    SizedBox(height: 6,),
                                    Text("Lets find quality food",style:TextStyle(color: Colors.grey[400],fontSize: 12,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((10)),
                                  color: Colors.amber[500],
                                ),
                                child: Image.asset(""),
                              )
                            ],
                          ),
                          SizedBox(height: 30,),

                          Text("Welcome to Spicy Dhaba",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                width: 265,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "search",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.green[700],
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                        color: Color(0x4D3D015B),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Text("Products Category",style: TextStyle(color: Color(0xFF222222),fontSize: 22,fontWeight: FontWeight.w500),),
                                SizedBox(height: 15,),
                                Container(
                                  color: Colors.white,
                                  height: 100,
                                  child:list.isEmpty == null ?
                                  Container(

                                  ):
                                  ListView.builder(
                                    itemCount:list.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Product current = list[index];
                                      return InkWell(
                                        onTap: (){
                                          setState(() {
                                            products=list[index].products[index];
                                            indx=current.categoryName;
                                          });
                                        },
                                        child: Categories(
                                          categoryname: list[index].categoryName,
                                          image: list[index].imageUrl,
                                          productcategory: indx,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  color: Colors.white,
                                  child:products==null?
                                  Container(
                                  ):

                                  ListView.builder(
                                    itemCount:list.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return Products(
                                        name:list[0].products[index].productName,
                                        image: list[0].products[index].imageUrl,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
class Products extends StatefulWidget {
  Products({this.name,this.image});
  final String name;
  final String image;
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25,horizontal: 20),
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(width: 100,child: Text(widget.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),)),
                    SizedBox(height: 8,),
                    Text("Hotbeef Pizza",style: TextStyle(color: Colors.grey[300],fontSize: 12,fontWeight: FontWeight.w400),),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department,color: Colors.orangeAccent,size: 18,),
                        SizedBox(width: 4,),
                        Text("24 calories",style: TextStyle(color: Colors.amber[400],fontWeight: FontWeight.w500,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Text("\$2.40",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Details(
                        productname: widget.name,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage("http://sowmyamatsa.pythonanywhere.com/${widget.image}"),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 15,)
      ],
    );
  }
}


class Categories extends StatefulWidget {
  const Categories({
    this.categoryname,
    this.productcategory,
    this.image,
    Key key,
  }) : super(key: key);
  final String categoryname;
  final String productcategory;
  final String image;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          height: 100,
          width: 55,
          decoration:widget.productcategory!=widget.categoryname?BoxDecoration(color: Colors.green[800],borderRadius: BorderRadius.circular(20),): BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber[400]
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                backgroundImage: NetworkImage("http://sowmyamatsa.pythonanywhere.com/${widget.image}"),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left:3.0),
                child: Text(widget.categoryname,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
              )
            ],
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}