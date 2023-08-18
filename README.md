# 字节跳动穿山甲广告、腾讯优量汇(广点通)聚合广告插件 Flutter版本

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_universalad"><img src=https://img.shields.io/pub/v/flutter_universalad?color=orange></a>
<a href="https://pub.flutter-io.cn/packages/flutter_universalad"><img src=https://img.shields.io/pub/likes/flutter_universalad></a>
<a href="https://pub.flutter-io.cn/packages/flutter_universalad"><img src=https://img.shields.io/pub/points/flutter_universalad></a>
<a href="https://github.com/gstory0404/flutter_universalad/commits"><img src=https://img.shields.io/github/last-commit/gstory0404/flutter_universalad></a>
<a href="https://github.com/gstory0404/flutter_universalad"><img src=https://img.shields.io/github/stars/gstory0404/flutter_universalad></a>
</p>
<p>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=VhD0AZSmzvsD3fu7CeQFkzpBQHMHANb1&authKey=W7JGJ0HKklyhP1jyBvbTF2Dkw0cq4UmhVSx2zXVdIm6n48Xrto%2B7%2B1n9jbkAadyF&noverify=0&group_code=649574038"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A4-649574038-blue></a>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=9I9lyXewEsEnx0f00EOF_9hEcFmG5Bmg&authKey=AJfQ8%2FhOLcoJ0p5B16EITjFav1IIs3UAerZSUsWZfa0evuklgxibHti51AYlZgI3&noverify=0&group_code=769626410"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A42-769626410-blue></a>
</p>

## 📢 推荐使用新版聚合插件[GTAds](https://github.com/gstory0404/GTAds)，支持自定义广告插入

## 简介
  flutter_universalad是一款聚合字节跳动穿山甲[flutter_unionad](https://github.com/gstory0404/flutter_unionad)、腾讯优量汇(广点通)[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)的聚合广告插件,方便直接调用多个厂商广告。[体验demo](https://www.pgyer.com/j7YB)
  
<img src="https://github.com/gstory0404/flutter_universalad/blob/master/images/universalad.gif" width="30%">
 
  
## 文档

推荐参考以下插件的文档进行插件的集成。

* [flutter_unionad](https://github.com/gstory0404/flutter_unionad)

* [flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)

## 开发环境
```
[✓] Flutter (Channel stable, 3.10.6, on macOS 13.5 22G74 darwin-x64, locale
    zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)
[✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2023.2)
[✓] VS Code (version 1.81.0)
[✓] Connected device (3 available)
[✓] Network resources
```

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_universalad: ^latest
```
  
#### 2、引入
```Dart
import 'package:flutter_universalad/flutter_universalad.dart';
```

## 使用

#### 1、SDK初始化

```Dart
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

```

#### 2、获取SDK版本
```Dart
VersionEntity versionEntity = await FlutterUniversalad.getSDKVersion();
    _sdkVersion =
        "穿山甲SDK ${versionEntity.pangolinVersion}  优量汇SDK ${versionEntity.tencentVersion}";
```

#### 3、激励广告

预加载激励广告

```dart
await FlutterUniversalad.loadRewardVideoAd(
        //穿山甲广告android id
        pAndroidId: "945418088",
        //穿山甲广告ios id
        pIosId: "945418088",
        //优量汇广告android id
        tAndroidId: "5042816813706194",
        //优量汇广告ios id
        tIosId: "8062535056034159",
        //奖励名称
        rewardName: "金币",
        //奖励数量
        rewardAmount: 10,
        //用户id
        userID: "123",
        //交替加载
        loadType: UniversalLoadType.INTURN,
        //穿山甲出现的几率
        probability: 0.5,
        //扩展参数，开启服务器验证时上报
        customData: "",
    );
```

激励广告监听

```dart
FlutterUniversalAdStreamSubscription? _subscripti;
_subscripti = FlutterUniversalAdStream.initAdStream(
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
   );
//移除监听
@override
void dispose() {
  super.dispose();
  _subscription?.cancel();
}
```
展示激励广告
```dart
FlutterUniversalad.showRewardVideoAd();
```

#### 4、插屏广告

预加载插屏广告

```dart
await FlutterUniversalad.loadInterstitialAd(
    //穿山甲广告android id
    pAndroidId: "946201351",
    //穿山甲广告ios id
    pIosId: "946201351",
    //优量汇广告android id
    tAndroidId: "9062813863614416",
    //优量汇广告ios id
    tIosId: "1052938046031440",
    //是否全屏 仅优量汇起效
    isFullScreen: false,
    //交替加载
    loadType: UniversalLoadType.INTURN,
    //穿山甲出现的几率
    probability: 0.5,
);
```

插屏广告监听

```dart
FlutterUniversalAdStreamSubscription? _subscripti;
_subscription = FlutterUniversalAdStream.initAdStream(
     uInteractionCallBack: UInteractionCallBack(
        onShow: (sdkType) {
          print("$sdkType  插屏广告开始显示");
        },
        onFail: (sdkType, code, message) {
         //只有两个插件都失败的情况下才会返回失败，只返回最后一次失败的参数，单独一个失败，会保底去拉取另一个sdk广告
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

//移除监听
@override
void dispose() {
  super.dispose();
  _subscription?.cancel();
}
```
展示插屏广告
```dart
FlutterUniversalad.showInterstitialAd();
```

#### 5、开屏广告

```dart
FlutterUniversalad.splashAdView(
        //穿山甲广告android id
        pAndroidId: "887367774",
        //穿山甲广告ios id
        pIosId: "887367774",
        //优量汇广告android id
        tAndroidId: "4052216802299999",
        //优量汇广告ios id
        tIosId: "8012030096434021",
        //广告加载模式 UniversalLoadType.INTURN 交替拉取广告，UniversalLoadType.RANDOWM 完全随机拉去广告
        loadType: UniversalLoadType.INTURN,
        //穿山甲出现的几率，UniversalLoadType.RANDOWM 起效，「0-1取值，0为不出现 1必出现」
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
        )
```

#### 6、信息流广告
```dart
FlutterUniversalad.nativeAdView(
                //穿山甲广告android id
                pAndroidId: "945417699",
                //穿山甲广告ios id
                pIosId: "945417699",
                //优量汇广告android id
                tAndroidId: "4072918853903023",
                //优量汇广告ios id
                tIosId: "7082132016439065",
                width: 400.0,
                height: 260.0,
                //广告加载模式 UniversalLoadType.INTURN 交替拉取广告，UniversalLoadType.RANDOWM 完全随机拉去广告
                loadType: UniversalLoadType.INTURN,
                //穿山甲出现的几率，UniversalLoadType.RANDOWM 起效，「0-1取值，0为不出现 1必出现」
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
```
#### 7、Banner广告
```dart
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
                //广告加载模式 UniversalLoadType.INTURN 交替拉取广告，UniversalLoadType.RANDOWM 完全随机拉去广告
                loadType: UniversalLoadType.INTURN,
                //穿山甲出现的几率，UniversalLoadType.RANDOWM 起效，「0-1取值，0为不出现 1必出现」
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
```

## 插件链接

|插件|地址|
|:----|:----|
|穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|聚合广告插件|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|百度百青藤广告插件|[flutter_baiduad](https://github.com/gstory0404/flutter_baiduad)|
|字节穿山甲内容合作插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|
|文档预览插件|[file_preview](https://github.com/gstory0404/file_preview)|
|滤镜|[gpu_image](https://github.com/gstory0404/gpu_image)|
|Gromore聚合广告|[gromore](https://github.com/gstory0404/gromore)|

### 开源不易，觉得有用的话可以请作者喝杯奶茶🧋
<img src="https://github.com/gstory0404/flutter_universalad/blob/master/images/weixin.jpg" width = "200" height = "160" alt="打赏"/>

## 联系方式
* Email: gstory0404@gmail.com
* Blog：https://www.gstory.cn/


