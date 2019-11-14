import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_java_jiao_hu/HttpCallBack.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'HttpRequest.dart';
class  ShuJuJiaoHu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    //返回一个State的widget页面
    return PageShuJuJiaoHuState();
  }
}

class  PageShuJuJiaoHuState extends State<ShuJuJiaoHu> {
  String result='默认值';
//  "samples.flutter.io/flutter_java_jiao_hu"
  //flutter_java_jiao_hu=项目名，保持和java的一致
  static const MethodChannel platform = const MethodChannel("samples.flutter.io/flutter_java_jiao_hu");
  //和java数据交互
  Future<void> login() async {
    try {
//      //调用Java的aaaa类型的方法（aaaa只是一个标识），和给Java传递参数
      String  str = await platform.invokeMethod("key_login",["a",1,true]);
//      //输出Java返回的数据
      print('str=${str}');
      result=str;
      setState(() {});
    } on Exception catch (e) {
      print('e=${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: new AppBar(
        title: new Text('和原生数据交互'),
      ),
      body:Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('和java进行数据交互'),
              onPressed: login,
            ),
            RaisedButton(
              child: Text('post请求'),
              onPressed: postData,
            ),
            RaisedButton(
              child: Text('get请求'),
              onPressed: getData,
            ),
            new Text('Column2似睡'),
            new Text('内容=${result}'),
          ],),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
//            _getStr();
//            httpGet();
          }),
    );
  }

  //返回String, 显示到text文本部件上
//调用接口 获取服务端数据
  Future<String> httpGet() async {
    final response =await http.get("https://wanandroid.com/wxarticle/chapters/json");
    final data = response.body;
    print('data=${data}');
    //刷新到页面
    result=data;
    setState(() {
    });
    return data;
  }
  Future <void> postData() async {
    HttpRequest hr=new HttpRequest();
    String url='https://omoapi.yuanxinkangfu.com/capp/api/api.html';
    Map parmars = {
      "root":{
        "head":{
          "client_id":"iOS",
          "user_id":"176",
          "channel_id":"AppStore",
          "screen":"1334*750",
          "os":"13.2",
          "softname":"1.2.2",
          "softver":"1",
          "device_id":"",
          "session_id":"22",
          "timestamp":"2019-11-11 14:07:58.205049",
          "action":"10001",
          "ua":"1"
        },
        "body":{
          "mobile":"13718809531",
          "code":"9531"
        }
      }
    };
    HttpRequest.getInstance().postVoid(url,
        parmars: parmars,
        success: (d)async{//添加异步
          print('请求数据--${d}----');
          //解密
          d=await platform.invokeMethod("key_decode",d);
          result=d;
          setState(() {});
        },
        failure: (e){
          print('错误信息--${e}');
        },
        finith: (){
          print('请求结束');
        });
  }


  Future <void> getData() async {
    String url='https://wanandroid.com/wxarticle/chapters/json';
    HttpRequest.getInstance().getVoid(url,
        success: (d){
          print('请求数据--${d}----');
          result=d;
          setState(() {});
        },
        failure: (e){
          print('错误信息--${e}');
        },
        finith: (){
          print('请求结束');
        });

  }
}