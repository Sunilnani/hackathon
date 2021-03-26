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
  List<ProductElement> products=List();
  void getHttp() async {
    setState(() {

    });
    try {
      Response response =
      await Dio().get("http://sowmyamatsa.pythonanywhere.com/categories_details/");
      setState(() {
        list = productFromJson(jsonEncode(response.data));
        _loading=true;
        products=list[0].products;
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
                color: Colors.pink[500],
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      decoration: BoxDecoration(
                        image:DecorationImage(image: AssetImage("img/background.jpg"),fit: BoxFit.cover)
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
                                    Text("Hey Customer",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800),),
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
                                child: Image.asset("img/profile.png",fit: BoxFit.cover,),
                              )
                            ],
                          ),
                          SizedBox(height: 30,),

                          Text("Welcome To Schezwan Spot",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
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
                                    color: Colors.amber[500],
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                        color: Color(0x4D3D015B),
                                      )
                                    ],
                                ),
                                child: Image.asset("img/search.png",fit: BoxFit.fitWidth,),
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
                                  child:list.length >0 ?
                                  ListView.builder(
                                    itemCount:list.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Product current = list[index];
                                      return InkWell(
                                        onTap: (){
                                          setState(() {
                                            products=list[index].products;
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
                                  ):Container(),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  color: Colors.white,
                                  child:list.length >0 ?

                                  ListView.builder(
                                    itemCount:products.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return Products(
                                        name:products[index].productName,
                                        image: products[index].imageUrl,
                                        price: products[index].productPrice,
                                        description: products[index].productDescription,
                                      );
                                    },
                                  ):Container(),
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
  Products({this.name,this.image,this.products,this.price,this.description});
  final String name;
  final String image;
  final ProductElement products;
  final double price;
  final String description;

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
                    Container(width: 130,child: Text(widget.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),)),
                    SizedBox(height: 8,),
                    Text("Full Stamina",style: TextStyle(color: Colors.grey[400],fontSize: 12,fontWeight: FontWeight.w400),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Spicy",style: TextStyle(color: Colors.amber[400],fontWeight: FontWeight.w500,fontSize: 14,fontStyle: FontStyle.italic,),),
                        SizedBox(width: 5,),
                        Icon(Icons.local_fire_department,color: Colors.red[600],size: 18,),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("\$ ${widget.price}",style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Details(
                        productname: widget.name,productimage: widget.image,productprice: widget.price,productdesc: widget.description,
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
          decoration:widget.productcategory!=widget.categoryname?BoxDecoration(color: Colors.green[800]
            ,borderRadius: BorderRadius.circular(20),
             boxShadow: [BoxShadow(
               offset: Offset(0, 3),
               blurRadius: 5,
               color: Colors.greenAccent[100],
             )
             ]
            ): BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber[400],
              boxShadow: [BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.amber[100],
              )
              ]
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
                child: Text(widget.categoryname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
              )
            ],
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}