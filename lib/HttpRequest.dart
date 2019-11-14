import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'HttpCallBack.dart';
import 'dart:convert' as convert;
class HttpRequest{
  static HttpRequest _instance;
  static HttpRequest getInstance(){
    if(null==_instance){
      _instance=new HttpRequest();
    }
    return _instance;
  }
  static const MethodChannel platform = const MethodChannel("samples.flutter.io/flutter_java_jiao_hu");

  /**
   * 回到
   * result=await hr.httpGet2(url, parmars,null);
   */
  Future <String> postString(String url,Map parmars,HttpCallBack callBack) async {

    Options options = Options(
      baseUrl: url,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = new Dio(options);
    Response response = await dio.post('',data: parmars);
    String data = response.data.toString();
    String  str = await platform.invokeMethod("key_decode",data);
    callBack.onSuccess(str);
    String result=data+'======='+str;
    print('data =========== $result');
    return str;
  }

  /**
   * post请求
      Future <void> postData() async {
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
   */
  Future <void> postVoid(String url,{Map parmars,success(d),failure(d),finith()}) async {

    try {
      Options options = Options(
        baseUrl: url,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      Dio dio = new Dio(options);
      Response response = await dio.post('',data: parmars);
//      print('response=${convert.json.encode(response)}');
      print("response.statusCode=${response.statusCode}");
      if(200==response.statusCode){
        String data = response.data.toString();
        //调用原生解密
//        data = await platform.invokeMethod("key_decode",data);
        if(null!=success){
          success(data);
        }
        print('data =========== $data');
      }else{
        if(null!=failure){
          failure(response.statusCode);
        }
      }
      if(null!=finith){
        finith();
      }
    } catch (e) {
//      print('>]error=${e.toString()}');
      print('>]error=${formatError(e)}');
      if(null!=failure){
        failure(e);
      }
      if(null!=finith){
        finith();
      }
      print(e);
    }
  }

  /**
   * get请求
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
   */
  Future <void> getVoid(String url,{Map parmars,success(d),failure(d),finith()}) async {

    try {
      Options options = Options(
        baseUrl: url,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      Dio dio = new Dio(options);
      Response response = await dio.get('',data: parmars);
//      print('response=${convert.json.encode(response)}');
      print("response.statusCode=${response.statusCode}");
      if(200==response.statusCode){
        String data = response.data.toString();
        //调用原生解密
//        data = await platform.invokeMethod("key_decode",data);
        if(null!=success){
          success(data);
        }
        print('data =========== $data');
      }else{
        if(null!=failure){
          failure(response.statusCode);
        }
      }
      if(null!=finith){
        finith();
      }
    } catch (e) {
//      print('>]error=${e.toString()}');
      print('>]error=${formatError(e)}');
      if(null!=failure){
        failure(e);
      }
      if(null!=finith){
        finith();
      }
    }
  }

  String formatError(DioError e) {
    String msg='';
    if (e.type == DioErrorType.DEFAULT) {
      msg="连接服务器";
    }else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      msg="连接超时";
    }else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
//It occurs when receiving timeout
      msg="响应超时";
    }else if (e.type == DioErrorType.RESPONSE) {
// When the server response, but with a incorrect status, such as 404, 503...
      msg="出现异常";
    }else if (e.type == DioErrorType.CANCEL) {
      msg="请求取消";
    }else {
      msg="其他错误";
    }
    return '错误信息=${msg},错误详情=${e.toString()}';
  }
}


//HttpRequest hr=new HttpRequest();
//String url='https://omoapi.yuanxinkangfu.com/capp/api/api.html';
//Map parmars = {
//  "root":{
//    "head":{
//      "client_id":"iOS",
//      "user_id":"176",
//      "channel_id":"AppStore",
//      "screen":"1334*750",
//      "os":"13.2",
//      "softname":"1.2.2",
//      "softver":"1",
//      "device_id":"",
//      "session_id":"22",
//      "timestamp":"2019-11-11 14:07:58.205049",
//      "action":"10001",
//      "ua":"1"
//    },
//    "body":{
//      "mobile":"13718809531",
//      "code":"9531"
//    }
//  }
//};