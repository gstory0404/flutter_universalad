import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Index> {
  String _registerResult = "";
  String _sdkVersion = "";

  @override
  void initState() {
    super.initState();
    _register();
    _initListener();
  }

  void _register() async {
    await FlutterUniversalad.register(
      pangolinId: "5098580",
      tencentId: "1200009850",
      appName: "Flutter_universalad",
      debug: true,
      callBack: RegisterCallBack(pangolinInit: (result) {
        setState(() {
          _registerResult = "$_registerResult 穿山甲初始化 $result";
        });
      }, tencentInit: (result) {
        setState(() {
          _registerResult = "$_registerResult 优量汇初始化 $result";
          _getVersion();
        });
      }),
    );
  }

  void _getVersion() async {
    VersionEntity versionEntity = await FlutterUniversalad.getSDKVersion();
    _sdkVersion =
        "穿山甲SDK ${versionEntity.pangolinVersion}  优量汇SDK ${versionEntity.tencentVersion}";
    setState(() {});
  }

  ///广告监听
  void _initListener() {
    FlutterUniversalAdStream.initAdStream(
      uRewardCallBack: URewardCallBack(
        onShow: (sdkType) {
          print("$sdkType  激励广告开始显示");
        },
        onFail: (sdkType, code, message) {
          print("$sdkType  激励广告失败 $code $message");
        },
        onClick: (sdkType) {
          print("$sdkType  激励广告点击");
        },
        onClose: (sdkType) {
          print("$sdkType  激励广告关闭");
        },
        onReady: (sdkType) {
          print("$sdkType  激励广告预加载完成");
          FlutterUniversalad.showRewardVideoAd();
        },
        onUnReady: (sdkType) {
          print("$sdkType  激励广告未预加载");
        },
        onVerify: (sdkType, transId, verify, amount, name) {
          print("$sdkType  激励广告观看成功 transId=$transId verify=$verify amount=$amount name=$name");
        },
      ),
      uInteractionCallBack: UInteractionCallBack(
        onShow: (sdkType) {
          print("$sdkType  插屏广告开始显示");
        },
        onFail: (sdkType, code, message) {
          print("$sdkType  插屏广告失败 $code $message");
        },
        onClick: (sdkType) {
          print("$sdkType  插屏广告点击");
        },
        onClose: (sdkType) {
          print("$sdkType  插屏广告关闭");
        },
        onReady: (sdkType) {
          print("$sdkType  插屏广告预加载完成");
          FlutterUniversalad.showInterstitialAd();
        },
        onUnReady: (sdkType) {
          print("$sdkType  插屏广告未预加载");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter_universalad'),
        ),
        body: Column(
          children: [
            Text('SDK初始化--> $_registerResult'),
            Text('SDK版本--> $_sdkVersion'),
            //激励广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('激励广告'),
              onPressed: () async {
                await FlutterUniversalad.loadRewardVideoAd(
                    pangolinId: "945418088",//穿山甲广告id
                    tencentId: "5042816813706194",//优量汇广告id
                    rewardName: "金币",//奖励名称
                    rewardAmount: 10,//奖励数量
                    userID: "123",//用户id
                    loadType: UniversalLoadType.INTURN,//交替加载
                    probability: 0.5);//穿山甲出现的几率
              },
            ),
            //插屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('插屏广告'),
              onPressed: () async {
                await FlutterUniversalad.loadInterstitialAd(
                    pangolinId: "946201351",//穿山甲广告id
                    tencentId: "9062813863614416",//优量汇广告id
                    isFullScreen: false,//是否全屏 仅优量汇起效
                    loadType: UniversalLoadType.INTURN,//交替加载
                    probability: 0.5);//穿山甲出现的几率
              },
            ),
          ],
        ),
      ),
    );
  }
}
