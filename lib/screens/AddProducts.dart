import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  Response response;
  Dio dio = new Dio();

  postTest() async {
    var requestBody = {
      'productId':201,
      'name':'sunil',
      'price':120.0,
      'imageUrl':'null',
      'categoryId':1
    };

    Response response = await dio.post("http://sowmyamatsa.pythonanywhere.com/category/"
     ,
      data: json.encode(requestBody),
      options: Options(headers:{'product_id':'1'})
    );

    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Press Here'),
            onPressed: (){
              postTest();
            },
          ),
        ),
      ),
    );
  }
}
