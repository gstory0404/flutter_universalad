# 字节跳动穿山甲广告、腾讯优量汇聚合广告插件 Flutter版本

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_universalad"><img src=https://img.shields.io/badge/flutter_universalad-v0.0.2-success></a>
</p>

## 简介
  flutter_universalad是一款聚合字节跳动穿山甲广告插件[flutter_unionad](https://github.com/gstory0404/flutter_unionad)、腾讯优量汇聚合广告[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)插件,方便直接调用多个厂商广告。
  
## 文档

推荐参考一下插件的文档进行插件的集成。

* [flutter_unionad](https://github.com/gstory0404/flutter_unionad)

* [flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)

## 本地环境
```
[✓] Flutter (Channel stable, 2.2.3, on macOS 11.5.1 20G80 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 2020.3)
[✓] VS Code (version 1.56.2)
[✓] Connected device (2 available)

```

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_universalad: ^0.0.2
```
  
#### 2、引入
```Dart
import 'package:flutter_universalad/flutter_universalad.dart';
```

## 使用

#### 1、SDK初始化

```Dart
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
                    pangolinId: "945418088",//穿山甲广告id
                    tencentId: "5042816813706194",//优量汇广告id
                    rewardName: "金币",//奖励名称
                    rewardAmount: 10,//奖励数量
                    userID: "123",//用户id
                    loadType: UniversalLoadType.INTURN,//UniversalLoadType.INTURN 交替拉取广告，UniversalLoadType.RANDOWM 完全随机拉去广告
                    probability: 0.5);//穿山甲出现的几率，UniversalLoadType.RANDOWM 起效，「0-1取值，0为不出现 1必出现」
              },
```

激励广告监听

```dart
FlutterUniversalAdStream.initAdStream(
      uRewardCallBack: URewardCallBack(
        onShow: (sdkType) {
          print("$sdkType  激励广告开始显示");
        },
        onFail: (sdkType, code, message) {
         //只有两个插件都失败的情况下才会返回失败，只返回最后一次失败的参数，单独一个失败，会保底去拉取另一个sdk广告
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
   );
```
展示激励广告
```dart
FlutterUniversalad.showRewardVideoAd();
```

#### 4、插屏广告

预加载插屏广告

```dart
await FlutterUniversalad.loadInterstitialAd(
                    pangolinId: "946201351",//穿山甲广告id
                    tencentId: "9062813863614416",//优量汇广告id
                    isFullScreen: false,//是否全屏 仅优量汇起效
                    loadType: UniversalLoadType.INTURN,//UniversalLoadType.INTURN 交替拉取广告，UniversalLoadType.RANDOWM 完全随机拉去广告
                    probability: 0.5);//穿山甲出现的几率，UniversalLoadType.RANDOWM 起效，「0-1取值，0为不出现 1必出现」
              },
```

插屏广告监听

```dart
FlutterUniversalAdStream.initAdStream(
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
```
展示插屏广告
```dart
FlutterUniversalad.showInterstitialAd();
```

## 说明

* 腾讯优量汇插件目前Android部分已经全部支持，ios部分暂时还不支持；穿山甲插件已经全部支持；聚合插件目前激励广告、插屏广告Android端回根据规则拉去穿山甲、优量汇数据，ios端只会拉去穿山甲的广告。

* 目前插件还在开发完善阶段，有需求或者想一起维护的可以加以下群。

## 插件链接

|插件|地址|
|:----|:----|
|穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|聚合广告插件|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|

## 联系方式
* Email: gstory0404@gmail.com

* QQ群: <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=4j2_yF1-pMl58y16zvLCFFT2HEmLf6vQ&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="649574038" title="flutter交流"></a>

