import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/models/single_product_model.dart';
import 'package:e_commerce/screens/homepage.dart';
import 'package:flutter/material.dart';

import 'AddProducts.dart';
import 'login_screen.dart';
class Details extends StatefulWidget {
  Details({this.productname,this.productimage,this.productprice});
  final String productname;
  final String productimage;
  final double productprice;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Product listTodos = Product();
  void getHttp() async {
    setState(() {
    });
    try {
      Response response =
      await Dio().get("http://sowmyamatsa.pythonanywhere.com/product/?product_id=${widget.productname}");
      setState(() {
        listTodos = productFromJson(jsonEncode(response.data)) ;
        print(response);
      });
      print(response);
    } catch (e) {
      setState(() {
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
        child: Stack(
          children: [
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(horizontal: 22,vertical: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>LoginScreen(
                                  ),
                                ),
                              );
                            },
                            child: Icon(Icons.arrow_back_ios,color: Colors.green[700],size: 22,)),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>AddProducts(
                                  ),
                                ),
                              );
                            },
                            child: Icon(Icons.add,color: Colors.green[700],size: 22,))
                      ],
                    ),
                    SizedBox(height: 15,),
                    Align(
                        alignment: Alignment.center,
                        child: Text(widget.productname,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 22),)),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 29),
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:NetworkImage("http://sowmyamatsa.pythonanywhere.com/${widget.productimage}"),fit: BoxFit.cover
                        ),
                        color: Colors.red,
                      ),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listTodos == null?Container():
                        Container(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department,color: Colors.orange[600],size: 18,),
                                  SizedBox(width: 5,),
                                  Text("${listTodos.categoryName}",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.w500,fontSize: 12),)
                                ],
                              ),
                              SizedBox(width: 10,),
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.amber[400],size: 18,),
                                  SizedBox(width: 5,),
                                  Text("4.9",style: TextStyle(color: Colors.grey[800],fontSize: 12,fontWeight: FontWeight.w500),)
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text("\$ ${widget.productprice}",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w700,fontSize: 22),),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.timer,color: Colors.pinkAccent,size: 18,),
                              SizedBox(width: 5,),
                              Text("Max 20-30 minutes",style: TextStyle(color: Colors.grey[800],fontSize: 12,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                        Container(
                          child: Icon(Icons.delivery_dining,color: Colors.green[800],size: 25,),
                        )
                      ],
                    ),
                    SizedBox(height: 25,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 20),)),
                    SizedBox(height: 10,),
                    Text("this is sowmya one of the good girl in our team but she is not introdusing his friends to me but in future she will definetely introduces me his friens thank you",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.greenAccent[100],
                            )
                          ],
                          color: Colors.green[800]
                      ),
                      child: Center(child: Text("Add To Cart",style: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 18),)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
