import 'package:flutter/material.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 12:02 下午
/// @Description: dart类作用描述

class NativePage extends StatefulWidget {
  const NativePage({Key? key}) : super(key: key);

  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "信息流广告",
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text("穿山甲广告"),
            //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945417699",
              //android 信息流广告id 必填
              iosCodeId: "945417699",
              //ios banner广告id 必填
              supportDeepLink: true,
              //是否支持 DeepLink 选填
              expressViewWidth: 375.5,
              // 期望view 宽度 dp 必填
              expressViewHeight: 275.5,
              //期望view高度 dp 必填
              expressNum: 2,
              mIsExpress: true,
              //一次请求广告数量 大于1小于3 必填
              callBack: FlutterUnionadNativeCallBack(
                onShow: () {
                  print("信息流广告显示");
                },
                onFail: (error) {
                  print("信息流广告失败 $error");
                },
                onDislike: (message) {
                  print("信息流广告不感兴趣 $message");
                },
                onClick: () {
                  print("信息流广告点击");
                },
              ),
            ),
            Text("优量汇广告"),
            FlutterTencentad.expressAdView(
              //广告id
                codeId: "7082132016439065",
                //广告宽 单位dp
                viewWidth: 400,
                //广告高  单位dp
                viewHeight: 300,
                //回调事件
                callBack: FlutterTencentadExpressCallBack(
                  onShow: () {
                    print("动态信息流广告显示");
                  },
                  onFail: (code, message) {
                    print("动态信息流广告错误 $code $message");
                  },
                  onClose: () {
                    print("动态信息流广告关闭");
                  },
                  onExpose: () {
                    print("动态信息流广告曝光");
                  },
                  onClick: () {
                    print("动态信息流广告点击");
                  },
                )
            ),
            Text("聚合广告"),
            FlutterUniversalad.nativeAdView(
              pangolinId: "945417699",
              tencentId: "7082132016439065",
              width: 400.0,
              height: 260.0,
              loadType: UniversalLoadType.INTURN,
              probability: 0.5,
              callBack: UNativeCallBack(
                onShow: (sdkType) {
                  print("$sdkType  Native广告显示");
                },
                onFail: (sdkType, code, message) {
                  print("$sdkType  Native广告失败  $code $message");
                },
                onClick: (sdkType) {
                  print("$sdkType  Native广告点击");
                },
                onClose: (sdkType) {
                  print("$sdkType  Native广告关闭");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
