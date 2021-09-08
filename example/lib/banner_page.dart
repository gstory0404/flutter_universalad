import 'package:flutter/material.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 12:02 下午
/// @Description: dart类作用描述

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "banner广告",
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text("穿山甲广告"),
            FlutterUnionad.bannerAdView(
              //andrrid banner广告id 必填
              androidCodeId: "945410197",
              //ios banner广告id 必填
              iosCodeId: "945410197",
              //是否使用个性化模版
              mIsExpress: true,
              //是否支持 DeepLink 选填
              supportDeepLink: true,
              //一次请求广告数量 大于1小于3 必填
              expressAdNum: 3,
              //轮播间隔事件 30-120秒  选填
              expressTime: 30,
              // 期望view 宽度 dp 必填
              expressViewWidth: 600.5,
              //期望view高度 dp 必填
              expressViewHeight: 120.5,
              //广告事件回调 选填
              callBack: FlutterUnionadBannerCallBack(
                  onShow: () {
                    print("banner广告加载完成");
                  },
                  onDislike: (message){
                    print("banner不感兴趣 $message");
                  },
                  onFail: (error){
                    print("banner广告加载失败 $error");
                  },
                  onClick: (){
                    print("banner广告点击");
                  }
              ),
            ),
            Text("优量汇广告"),
            FlutterTencentad.bannerAdView(
              androidId: "8042711873318113",
              //广告id
              iosId: "6062430096832369",
              //广告宽 单位dp
              viewWidth: 500,
              //广告高  单位dp   宽高比应该为6.4:1
              viewHeight: 100,
              // 广告回调
              callBack: FlutterTencentadBannerCallBack(
                onShow: () {
                  print("Banner广告显示");
                },
                onFail: (code, message) {
                  print("Banner广告错误 $code $message");
                },
                onClose: () {
                  print("Banner广告关闭");
                },
                onExpose: () {
                  print("Banner广告曝光");
                },
                onClick: () {
                  print("Banner广告点击");
                },
              ),
            ),
            Text("聚合广告"),
            FlutterUniversalad.bannerAdView(
              //穿山甲广告android id
              pAndroidId: "945410197",
              //穿山甲广告ios id
              pIosId: "945410197",
              //优量汇广告android id
              tAndroidId: "8042711873318113",
              //优量汇广告ios id
              tIosId: "6062430096832369",
              width: 300.0,
              height: 100.0,
              loadType: UniversalLoadType.INTURN,
              probability: 0.5,
              callBack: UBannerCallBack(
                onShow: (sdkType) {
                  print("$sdkType  Banner广告显示");
                },
                onFail: (sdkType, code, message) {
                  print("$sdkType  Banner广告失败  $code $message");
                },
                onClick: (sdkType) {
                  print("$sdkType  Banner广告点击");
                },
                onClose: (sdkType) {
                  print("$sdkType  Banner广告关闭");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
