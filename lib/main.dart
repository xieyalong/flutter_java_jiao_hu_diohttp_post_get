

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_java_jiao_hu/ShuJuJiaoHu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform View',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Platform View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  "samples.flutter.io/flutter_java_jiao_hu"
  //flutter_java_jiao_hu=项目名，保持和java的一致
  static const MethodChannel platform = const MethodChannel("samples.flutter.io/flutter_java_jiao_hu");


  Future<void> startActivity() async {
    Map map={'a':'A'};
     String str =await platform.invokeMethod('key_startActivity', map);
    print('>]------s${str}');
    setState(() { });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '',
                  style: const TextStyle(fontSize: 17.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RaisedButton(
                      child:const Text('跳转原生页面'),
                      onPressed: startActivity
                  ),
                ),
                RaisedButton(
                  child: Text('和原生数据交互'),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(
                      //传递参数
                        builder:(context)=> new ShuJuJiaoHu()
                    ) );
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
          child: Row(
            children: <Widget>[
              Image.asset('assets/flutter-mark-square-64.png',
                  scale: 1.5),
              const Text(
                'Flutter',
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ),
      ],
    ),

  );
}
