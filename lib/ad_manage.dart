import 'dart:io';
import 'dart:math';

import 'package:flutter_tencentad/flutter_tencentad.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_universalad/ad_code.dart';
import 'package:flutter_universalad/entity/native_load_bean.dart';
import 'package:flutter_universalad/entity/splash_load_bean.dart';

import 'entity/banner_load_bean.dart';
import 'entity/interstitial_load_bean.dart';
import 'entity/reward_load_bean.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/10 5:41 下午
/// @Description: 广告管理类

class AdManage {
  factory AdManage() => _getInstance();

  static AdManage get instance => _getInstance();

  static AdManage? _instance;

  AdManage._() {
    rewardLoadBean = RewardLoadBean();
    interstitialLoadBean = InterstitialLoadBean();
    bannerLoadBean = BannerLoadBean();
    nativeLoadBean = NativeLoadBean();
    splashLoadBean = SplashLoadBean();
  }

  static AdManage _getInstance() {
    if (_instance == null) {
      _instance = AdManage._();
    }
    return _instance!;
  }

  //激励广告缓存
  late RewardLoadBean rewardLoadBean;

  //插屏广告缓存
  late InterstitialLoadBean interstitialLoadBean;

  //banner广告缓存
  late BannerLoadBean bannerLoadBean;

  //信息流广告缓存
  late NativeLoadBean nativeLoadBean;

  //开屏广告上一次缓存
  late SplashLoadBean splashLoadBean;

  ///
  /// 计算将要加载哪个SDK广告
  ///
  /// [adtype] 广告类型[AdType]
  ///
  /// [loadType] 广告选取方式[UniversalLoadType]
  ///
  /// [probability] 当选取方式为[LoadType.RANDOWM] 随即时 穿山甲广告出现的比例 「0-1取值，0为不出现 1必出现」
  ///
  Future<int> getLoadAdtype(
      int adtype, int loadType, double probability) async {
    var sdkType = UniversalSdkKType.PANGOLIN;
    //随即加载
    if (loadType == UniversalLoadType.RANDOWM) {
      sdkType = await _getRandomLoadType(probability);
      //依次加载
    } else if (loadType == UniversalLoadType.INTURN) {
      //目前ios暂不支持优量汇

      //激励广告
      if (adtype == UniversalAdType.REWARD) {
        if (rewardLoadBean.lastSdk == UniversalSdkKType.PANGOLIN) {
          sdkType = UniversalSdkKType.TENCENT;
        } else {
          sdkType = UniversalSdkKType.PANGOLIN;
        }
        //插屏广告
      } else if (adtype == UniversalAdType.INTERSTITIAL) {
        if (interstitialLoadBean.lastSdk == UniversalSdkKType.PANGOLIN) {
          sdkType = UniversalSdkKType.TENCENT;
        } else {
          sdkType = UniversalSdkKType.PANGOLIN;
        }
        //banner广告
      } else if (adtype == UniversalAdType.BANNER) {
        if (bannerLoadBean.lastSdk == UniversalSdkKType.PANGOLIN) {
          sdkType = UniversalSdkKType.TENCENT;
        } else {
          sdkType = UniversalSdkKType.PANGOLIN;
        }
        //信息流广告
      } else if (adtype == UniversalAdType.NATIVE) {
        if (nativeLoadBean.lastSdk == UniversalSdkKType.PANGOLIN) {
          sdkType = UniversalSdkKType.TENCENT;
        } else {
          sdkType = UniversalSdkKType.PANGOLIN;
        }
        //开屏广告
      } else if (adtype == UniversalAdType.SPLAH) {
        if (splashLoadBean.lastSdk == UniversalSdkKType.PANGOLIN) {
          sdkType = UniversalSdkKType.TENCENT;
        } else {
          sdkType = UniversalSdkKType.PANGOLIN;
        }
      }
    }
    return sdkType;
  }

  ///生成随即数 获取当次该使用哪个sdk广告
  Future<int> _getRandomLoadType(double probability) async {
    var random = Random().nextDouble();
    if (random > probability) {
      return UniversalSdkKType.TENCENT;
    }
    return UniversalSdkKType.PANGOLIN;
  }

  ///
  ///预加载激励视频广告
  ///
  /// [type] 广告SDK
  ///
  void loadRewardAd(int type) async {
    rewardLoadBean.lastSdk = type;
    if (type == UniversalSdkKType.TENCENT) {
      //优量汇
      await FlutterTencentad.loadRewardVideoAd(
          codeId: rewardLoadBean.tencentId,
          rewardName: rewardLoadBean.rewardName,
          rewardAmount: rewardLoadBean.rewardAmount,
          userID: rewardLoadBean.userID);
    } else {
      //穿山甲
      await FlutterUnionad.loadRewardVideoAd(
          mIsExpress: false,
          androidCodeId: rewardLoadBean.pangolinId,
          iosCodeId: rewardLoadBean.pangolinId,
          rewardName: rewardLoadBean.rewardName,
          rewardAmount: rewardLoadBean.rewardAmount,
          userID: rewardLoadBean.userID);
    }
  }

  ///
  ///预加载插屏广告
  ///
  /// [type] 广告SDK
  ///
  void loadInteractionAd(int type) {
    interstitialLoadBean.lastSdk = type;
    if (type == UniversalSdkKType.TENCENT) {
      //优量汇
      FlutterTencentad.loadUnifiedInterstitialAD(
        codeId: interstitialLoadBean.tencentId,
        isFullScreen: interstitialLoadBean.isFullScreen,
      );
    } else {
      //穿山甲
      FlutterUnionad.loadFullScreenVideoAdInteraction(
        androidCodeId: interstitialLoadBean.pangolinId,
        iosCodeId: interstitialLoadBean.pangolinId,
      );
    }
  }
}
