import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/all_products_model.dart';
import 'package:e_commerce/models/data_model.dart';
import 'package:e_commerce/models/delete_model.dart';
import 'package:e_commerce/models/patch_model.dart';
import 'package:e_commerce/models/post_model.dart';
import 'package:e_commerce/screens/catg_prod_adding.dart';
import 'package:e_commerce/screens/delete_catg_prod.dart';
import 'package:e_commerce/screens/patch_prod_catg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'details.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  String petcategory="";
  String indx="";
  int categoryindx;
  List<Product> list=List();
  bool _loading = false;
  List<ProductElement> products=List();

  File img;
  final TextController = TextEditingController();
  final idcontroller = TextEditingController();
  final nameController=TextEditingController();
  final categoryidController= TextEditingController();
  Category category=Category();
  Delete createcatg= Delete();
  Patchcategory patchcatg=Patchcategory();
  dynamic res ;
  dynamic respo;
  dynamic patchresponse;
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
  void deletecategory() async {
    String  number = idcontroller.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "category_id" : number
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
        "category_id":categoryid
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
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                        child: Text("upload_image"),
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
                            res=res;
                          });
                        }),
                    res == null ? Text("no data")  : Text("test --- ${res}"),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }
  _deletecategory(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    respo == null ?Text("enter valid id") :Text("category --- ${respo}"),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              ),
              // respo == null ?Text("enter valid id") :Text("test --- ${respo}"),
            ],
          );
        });
  }
  _patchDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Patch Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    // patchresponse==null?Text("enter valid id"):Text(patchresponse),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }
  @override
  void initState() {
    getHttp();
    super.initState();
    patchcategory();
    addcategory();
    deletecategory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  height: 40,
                                  width: 265,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white
                                  ),
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                        color: Color(0xFFADADAD),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // child: TextField(
                                  //   decoration: InputDecoration(
                                  //       hintText: "search",
                                  //       hintStyle: TextStyle(color: Colors.grey),
                                  //       border: InputBorder.none
                                  //   ),
                                  // ),
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
                                  child: Icon(Icons.search,size: 25,),
                                  // child: Image.asset("img/search.png",fit: BoxFit.fitWidth,),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Categories",style: TextStyle(color: Color(0xFF222222),fontSize: 22,fontWeight: FontWeight.w700),),
                                      ),
                                      Container(),
                                      InkWell(
                                        onTap: (){
                                          _displayDialog(context);
                                       },
                                        child: Container(
                                          height: 30,
                                          width: 35,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.tealAccent),
                                          child: Icon(Icons.add,size: 20,),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          _deletecategory(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 35,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.amber),
                                          child: Icon(Icons.delete_outline_sharp,size: 20,),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          _patchDialog(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 35,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey),
                                          child: Icon(Icons.edit,size: 20,),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                              categoryindx=current.categoryId;
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Products",style: TextStyle(color: Color(0xFF222222),fontSize: 22,fontWeight: FontWeight.w700),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    color: Colors.white,
                                    child:products.length >0 ?
                                    ListView.builder(
                                      itemCount:products.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics:NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return InkWell(
                                          onTap: (){
                                            setState(() {

                                            });
                                          },
                                          child: Products(
                                            name:products[index].productName,
                                            image: products[index].imageUrl,
                                            price: products[index].productPrice,
                                            description: products[index].productDescription,
                                            calories: products[index].calories,
                                            category_id:categoryindx,
                                            product_id: products[index].productId,
                                          ),
                                        );
                                      },
                                    ):Container(),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>Add_catg_prod(

                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:Colors.green[800]),
                                        child: Text("Add Product",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w700),),
                                      ),
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
      ),
    );
  }
}
class Products extends StatefulWidget {
  Products({this.name,this.image,this.products,this.price,this.description,this.calories,this.category_id,this.product_id,});
  final String name;
  final String image;
  final ProductElement products;
  final double price;
  final String description;
  final int calories;
  final int category_id;
  final int product_id;

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  dynamic responses;
  dynamic res;
  File productimag ;
  final productnameController=TextEditingController();
  final descriptionContoller = TextEditingController();
  final priceCotroller = TextEditingController();
  final caloryCotroller = TextEditingController();
  final categoryIdcontoller = TextEditingController();
  final numberController=TextEditingController();
  final patch_product_idController= TextEditingController();
  final patch_product_nameController=TextEditingController();
  final patch_priceController=TextEditingController();
  final patch_category_idController= TextEditingController();


  Products deleteprod= Products();
  Products createcatg= Products();
  dynamic prodres;
  void deleteproducts() async {
    String  id = numberController.text.trim();
    try {
      FormData formData = FormData.fromMap({
        "product_id" :widget.product_id
      });
      Response response =
      await Dio().delete("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        deleteprod = productsFromJson(jsonEncode(response.data)) as Products;
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
  _deleteproduct(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }


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
        "category_id":widget.category_id,
        "calories":calory,
        "image":await MultipartFile.fromFile(productimag.path)
      });
      Response response =
      await Dio().post("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data)) as Products;
        print(response.data);
        responses=response.data["message"];
      });
    }
    catch(e){

    }
  }
  _addproduct(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                          productsadd();
                          setState(() {

                          });
                        }),
                    responses==null ?Text("enter valid details"):Text(responses),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

  void patchproduct()async{
    String  product_id = patch_product_idController.text.trim();
    String patch_name = patch_product_nameController.text.trim();
    String patch_prise = patch_priceController.text.trim();
    String category_id = patch_category_idController.text.trim();
    try{
      FormData formData = FormData.fromMap({
        "product_id" : widget.product_id,
        "name":patch_name,
        "price":patch_prise,
        "category_id":widget.category_id
      });
      Response response =
      await Dio().patch("http://sowmyamatsa.pythonanywhere.com/product/" , data: formData);
      setState(() {
        createcatg = productsFromJson(jsonEncode(response.data)) as Products;
        print(response.data);
        res=response.data["message"];
      });
    }
    catch(e){

    }
  }
  _patchproduct(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Category'),
            content: Container(
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }

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
                padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
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
                        Icon(Icons.local_fire_department,color: Colors.red[600],size: 18,),
                        SizedBox(width: 5,),

                        Text("${widget.calories} calories",style: TextStyle(color: Colors.amber[400],fontWeight: FontWeight.w500,fontSize: 14,fontStyle: FontStyle.italic,),),
                      ],
                    ),
                    SizedBox(height: 8,),
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
                    radius: 65,
                    backgroundImage: NetworkImage("http://sowmyamatsa.pythonanywhere.com/${widget.image}"),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>Add_catg_prod(categoryid: widget.category_id,
                          //     ),
                          //   ),);
                          _addproduct(context);
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.tealAccent),
                        child: Icon(Icons.add,size: 20,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        _deleteproduct(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>Delete_catg_prod(productid: widget.product_id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.amber),
                        child: Icon(Icons.delete_outline_sharp,size: 20,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => Update(
                        //
                        //     ),
                        //   ),
                        // );
                        _patchproduct(context);
                      },
                      child: Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey),
                        child: Icon(Icons.edit,size: 20,),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 15,),
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
          padding: EdgeInsets.symmetric(vertical:8),
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:3.0),
                child: Text(widget.categoryname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize:9),),
              )
            ],
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}