import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_tencentad/flutter_tencentad.dart';
import 'package:flutter_universalad/ad_code.dart';
import 'package:flutter_universalad/entity/version_entity.dart';
import 'package:flutter_universalad/widget/banner_ad_view.dart';
import 'package:flutter_universalad/widget/native_ad_view.dart';
import 'package:flutter_universalad/widget/splash_ad_view.dart';

import 'ad_manage.dart';
import 'entity/register_entity.dart';
import 'method_callback.dart';

export 'package:flutter_universalad/entity/version_entity.dart';
export 'package:flutter_universalad/ad_code.dart';
export 'package:flutter_universalad/method_callback.dart';
export 'flutter_universalad_stream.dart';

//穿山甲
export 'package:flutter_unionad/flutter_unionad_stream.dart';
export 'package:flutter_unionad/flutter_unionad_code.dart';
export 'package:flutter_unionad/flutter_unionad.dart';

//优量汇
export 'package:flutter_tencentad/flutter_tencentad.dart';
export 'package:flutter_tencentad/flutter_tencentad_stream.dart';
export 'package:flutter_tencentad/flutter_tencentad_code.dart.dart';

class FlutterUniversalad {
  static const MethodChannel _channel =
      const MethodChannel('flutter_universalad');

  ///
  /// # SDK注册初始化
  ///
  /// [pangolinId] 穿山甲appId
  ///
  /// [tencentId] 优量汇appId
  ///
  /// [appName] app名称
  ///
  /// [debug] 是否显示日志log
  ///
  /// [callBack] 初始化回调
  ///
  static Future<void> register({
    required String pangolinId,
    required String tencentId,
    required String appName,
    bool? debug,
    RegisterCallBack? callBack,
  }) async {
    bool pangolinInit = await FlutterUnionad.register(
      iosAppId: pangolinId,
      androidAppId: pangolinId,
      appName: appName,
      debug: debug,
    );
    bool tencentInit =
        await FlutterTencentad.register(appId: tencentId, debug: debug);
    callBack?.pangolinInit!(pangolinInit);
    callBack?.tencentInit!(tencentInit);
  }

  ///
  /// # 获取SDK版本号
  ///
  static Future<VersionEntity> getSDKVersion() async {
    VersionEntity versionEntity = new VersionEntity();
    versionEntity.pangolinVersion = await FlutterUnionad.getSDKVersion();
    versionEntity.tencentVersion = await FlutterTencentad.getSDKVersion();
    return versionEntity;
  }

  /// # 激励视频广告预加载
  ///
  /// [pangolinId] 穿山甲广告id 必填
  ///
  /// [tencentId] 优量汇广告id 必填
  ///
  /// [rewardName] 奖励名字
  ///
  /// [rewardAmount] 奖励数量
  ///
  /// [userID] 用户id
  ///
  /// [loadType] 广告选取方式 [UniversalLoadType.RANDOWM]随机  [UniversalLoadType.INTURN]依次交替加载
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随机时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  static Future<void> loadRewardVideoAd({
    required String pangolinId,
    required String tencentId,
    required String rewardName,
    required int rewardAmount,
    required String userID,
    required int loadType,
    required double probability,
  }) async {
    //保存数据
    AdManage.instance.rewardLoadBean.pangolinId = pangolinId;
    AdManage.instance.rewardLoadBean.tencentId = tencentId;
    AdManage.instance.rewardLoadBean.rewardName = rewardName;
    AdManage.instance.rewardLoadBean.rewardAmount = rewardAmount;
    AdManage.instance.rewardLoadBean.userID = userID;
    AdManage.instance.rewardLoadBean.loadType = loadType;
    AdManage.instance.rewardLoadBean.probability = probability;
    int type = await AdManage.instance
        .getLoadAdtype(UniversalAdType.REWARD, loadType, probability);
    AdManage.instance.rewardLoadBean.lastShowSuccess = true;
    //加载
    AdManage.instance.loadRewardAd(type);
  }

  ///
  /// # 显示激励广告
  ///
  static Future<void> showRewardVideoAd() async {
    if (AdManage.instance.rewardLoadBean.lastSdk == UniversalSdkKType.TENCENT) {
      await FlutterTencentad.showRewardVideoAd();
    } else {
      await FlutterUnionad.showRewardVideoAd();
    }
  }

  ///
  /// # 预加载插屏广告
  ///
  /// [pangolinId] 穿山甲广告id 必填
  ///
  /// [tencentId] 优量汇广告id 必填
  ///
  ///  [isFullScreen] 是否全屏 仅优量汇起效
  ///
  /// [loadType] 广告选取方式 [UniversalLoadType.RANDOWM]随机  [UniversalLoadType.INTURN]依次交替加载
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随机时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  static Future<void> loadInterstitialAd({
    required String pangolinId,
    required String tencentId,
    required bool isFullScreen,
    required int loadType,
    required double probability,
  }) async {
    //保存数据
    AdManage.instance.interstitialLoadBean.pangolinId = pangolinId;
    AdManage.instance.interstitialLoadBean.tencentId = tencentId;
    AdManage.instance.interstitialLoadBean.isFullScreen = isFullScreen;
    int type = await AdManage.instance
        .getLoadAdtype(UniversalAdType.INTERSTITIAL, loadType, probability);
    AdManage.instance.interstitialLoadBean.lastShowSuccess = true;
    AdManage.instance.loadInteractionAd(type);
  }

  ///
  /// # 显示新模板渲染插屏
  ///
  static Future<void> showInterstitialAd() async {
    if (AdManage.instance.interstitialLoadBean.lastSdk ==
        UniversalSdkKType.TENCENT) {
      print("222广告sdk类型 ${AdManage.instance.interstitialLoadBean.lastSdk}");
      await FlutterTencentad.showUnifiedInterstitialAD();
    } else {
      print("111广告sdk类型 ${AdManage.instance.interstitialLoadBean.lastSdk}");
      await FlutterUnionad.showFullScreenVideoAdInteraction();
    }
  }

  ///
  /// Banner广告
  ///
  /// [pangolinId] 穿山甲广告id
  ///
  /// [tencentId] 优量汇广告id
  ///
  /// [width] 宽 dp
  ///
  /// [height] 高 dp
  ///
  /// [loadType] 广告选取方式 [UniversalLoadType.RANDOWM]随机  [UniversalLoadType.INTURN]依次交替加载
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随机时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  /// [UBannerCallBack] 广告回调
  ///
  static Widget bannerAdView({
    required String pangolinId,
    required String tencentId,
    required double width,
    required double height,
    required int loadType,
    required double probability,
    required UBannerCallBack? callBack,
  }) {
    return BannerAdView(
      pangolinId: pangolinId,
      tencentId: tencentId,
      width: width,
      height: height,
      loadType: loadType,
      probability: probability,
      callBack: callBack,
    );
  }

  ///
  /// 信息流广告
  ///
  /// [pangolinId] 穿山甲广告id
  ///
  /// [tencentId] 优量汇广告id
  ///
  /// [width] 宽 dp
  ///
  /// [height] 高 dp
  ///
  /// [loadType] 广告选取方式 [UniversalLoadType.RANDOWM]随机  [UniversalLoadType.INTURN]依次交替加载
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随机时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  /// [UNativeCallBack] 广告回调
  ///
  static Widget nativeAdView({
    required String pangolinId,
    required String tencentId,
    required double width,
    required double height,
    required int loadType,
    required double probability,
    required UNativeCallBack? callBack,
  }) {
    return NativeAdView(
      pangolinId: pangolinId,
      tencentId: tencentId,
      width: width,
      height: height,
      loadType: loadType,
      probability: probability,
      callBack: callBack,
    );
  }

  ///
  /// 信息流广告
  ///
  /// [pangolinId] 穿山甲广告id
  ///
  /// [tencentId] 优量汇广告id
  ///
  /// [width] 宽 dp
  ///
  /// [height] 高 dp
  ///
  /// [loadType] 广告选取方式 [UniversalLoadType.RANDOWM]随机  [UniversalLoadType.INTURN]依次交替加载
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随机时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  /// [USplashCallBack] 广告回调
  ///
  static Widget splashAdView({
    required String pangolinId,
    required String tencentId,
    required int loadType,
    required double probability,
    required USplashCallBack? callBack,
  }) {
    return SplashAdView(
      pangolinId: pangolinId,
      tencentId: tencentId,
      loadType: loadType,
      probability: probability,
      callBack: callBack,
    );
  }
}
