import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 4:45 下午
/// @Description: dart类作用描述

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      child: FlutterUniversalad.splashAdView(
        pangolinId: "887367774",
        tencentId: "4052216802299999",
        loadType: UniversalLoadType.INTURN,
        probability: 0.5,
        callBack: USplashCallBack(
          onShow: (sdkType) {
            print("$sdkType  开屏广告显示");
          },
          onFail: (sdkType, code, message) {
            print("$sdkType  开屏广告失败  $code $message");
            Navigator.pop(context);
          },
          onClick: (sdkType) {
            print("$sdkType  开屏广告点击");
          },
          onClose: (sdkType) {
            print("$sdkType  开屏广告关闭");
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
