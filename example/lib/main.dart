import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_universalad/flutter_universalad.dart';
import 'package:flutter_universalad_example/banner_page.dart';
import 'package:flutter_universalad_example/native_page.dart';
import 'package:flutter_universalad_example/splash_page.dart';

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

  FlutterUniversalAdStreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _register();
    _initListener();
  }

  void _register() async {
    await FlutterUniversalad.register(
      pAndroidId: "5098580",
      //穿山甲android id
      pIosId: "5098580",
      //穿山甲ios id
      tAndroidId: "1200009850",
      //优量汇android id
      tIosId: "1200082163",
      //优量汇ios id
      appName: "Flutter_universalad",
      //app名字
      debug: true,
      //是否显示日志
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
    _subscription = FlutterUniversalAdStream.initAdStream(
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
          print(
              "$sdkType  激励广告观看成功 transId=$transId verify=$verify amount=$amount name=$name");
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text('SDK初始化--> $_registerResult'),
                Text('SDK版本--> $_sdkVersion'),
                //穿山甲激励广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('穿山甲激励广告'),
                  onPressed: () async {
                    FlutterUnionad.loadRewardVideoAd(
                      mIsExpress: true,
                      //是否个性化 选填
                      androidCodeId: "945418088",
                      //Android 激励视频广告id  必填
                      iosCodeId: "945418088",
                      //ios 激励视频广告id  必填
                      supportDeepLink: true,
                      //是否支持 DeepLink 选填
                      rewardName: "穿山甲奖励金币",
                      //奖励名称 选填
                      rewardAmount: 199,
                      //奖励数量 选填
                      userID: "123",
                      //  用户id 选填
                      orientation: FlutterUnionadOrientation.VERTICAL,
                      //视屏方向 选填
                      mediaExtra: null, //扩展参数 选填
                    );
                  },
                ),
                //优量汇激励广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('优量汇激励广告'),
                  onPressed: () async {
                    await FlutterTencentad.loadRewardVideoAd(
                      androidId: "5042816813706194",
                      //广告id
                      iosId: "4023171869997790",
                      rewardName: "优量汇奖励金币",
                      rewardAmount: 299,
                      userID: "123",
                    );
                  },
                ),
                //聚合激励广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('聚合激励广告'),
                  onPressed: () async {
                    await FlutterUniversalad.loadRewardVideoAd(
                      //穿山甲广告android id
                      pAndroidId: "945418088",
                      //穿山甲广告ios id
                      pIosId: "945418088",
                      //优量汇广告android id
                      tAndroidId: "5042816813706194",
                      //优量汇广告ios id
                      tIosId: "4023171869997790",
                      //奖励名称
                      rewardName: "聚合奖励金币",
                      //奖励数量
                      rewardAmount: 399,
                      //用户id
                      userID: "123",
                      //交替加载
                      loadType: UniversalLoadType.INTURN,
                      //穿山甲出现的几率
                      probability: 0.5,
                      //扩展参数，开启服务器验证时上报
                      customData: "",
                    );
                  },
                ),
                //穿山甲插屏广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('穿山甲插屏广告'),
                  onPressed: () async {
                    FlutterUnionad.loadFullScreenVideoAdInteraction(
                      androidCodeId: "946201351", //android 全屏广告id 必填
                      iosCodeId: "946201351", //ios 全屏广告id 必填
                      supportDeepLink: true, //是否支持 DeepLink 选填
                      orientation: FlutterUnionadOrientation.VERTICAL, //视屏方向 选填
                    );
                  },
                ),
                //优量汇插屏广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('优量汇插屏广告'),
                  onPressed: () async {
                    await FlutterTencentad.loadUnifiedInterstitialAD(
                      //android广告id
                      androidId: "9062813863614416",
                      //广告id
                      iosId: "5093576955904702",
                      //是否全屏
                      isFullScreen: false,
                    );
                  },
                ),
                //聚合插屏广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('聚合插屏广告'),
                  onPressed: () async {
                    await FlutterUniversalad.loadInterstitialAd(
                      //穿山甲广告android id
                      pAndroidId: "946201351",
                      //穿山甲广告ios id
                      pIosId: "946201351",
                      //优量汇广告android id
                      tAndroidId: "9062813863614416",
                      //优量汇广告ios id
                      tIosId: "5093576955904702",
                      //是否全屏 仅优量汇起效
                      isFullScreen: false,
                      //交替加载
                      loadType: UniversalLoadType.INTURN,
                      //穿山甲出现的几率
                      probability: 0.5,
                    ); //穿山甲出现的几率
                  },
                ),
                //Banner广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('Banner广告'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new BannerPage(),
                      ),
                    );
                  },
                ),
                //信息流广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('信息流广告'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new NativePage(),
                      ),
                    );
                  },
                ),
                //开屏广告
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: new Text('开屏广告'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new SplashPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
