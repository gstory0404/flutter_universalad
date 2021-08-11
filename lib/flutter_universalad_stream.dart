import 'dart:async';

import 'package:flutter_tencentad/flutter_tencentad.dart';
import 'package:flutter_universalad/ad_manage.dart';
import 'package:flutter_universalad/flutter_universalad.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

import 'ad_code.dart';
import 'method_callback.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/10 7:08 下午
/// @Description: dart类作用描述

class FlutterUniversalAdStream {
  static void initAdStream({
    URewardCallBack? uRewardCallBack,
    UInteractionCallBack? uInteractionCallBack,
  }) {
    FlutterTencentAdStream.initAdStream(
      //激励广告
      rewardAdCallBack: RewardAdCallBack(
        onShow: () {
          // print("激励广告显示");
          uRewardCallBack?.onShow!(UniversalSdkKType.TENCENT);
        },
        onClick: () {
          // print("激励广告点击");
          uRewardCallBack?.onClick!(UniversalSdkKType.TENCENT);
        },
        onFail: (code, message) {
          // print("激励广告失败 $code $message");
          if (AdManage.instance.rewardLoadBean.lastShowSuccess) {
            AdManage.instance.rewardLoadBean.lastShowSuccess = false;
            AdManage.instance.loadRewardAd(UniversalSdkKType.PANGOLIN);
          } else {
            uRewardCallBack?.onFail!(UniversalSdkKType.TENCENT, code, message);
          }
        },
        onClose: () {
          // print("激励广告关闭");
          uRewardCallBack?.onClick!(UniversalSdkKType.TENCENT);
        },
        onReady: () async {
          // print("激励广告预加载准备就绪");
          uRewardCallBack?.onReady!(UniversalSdkKType.TENCENT);
        },
        onUnReady: () {
          // print("激励广告预加载未准备就绪");
          uRewardCallBack?.onUnReady!(UniversalSdkKType.TENCENT);
        },
        onVerify: (transId) {
          // print("激励广告奖励  $transId");
          uRewardCallBack?.onVerify!(
              UniversalSdkKType.TENCENT,
              transId,
              true,
              AdManage.instance.rewardLoadBean.rewardAmount,
              AdManage.instance.rewardLoadBean.rewardName);
        },
      ),
      //插屏广告
      interactionAdCallBack: InteractionAdCallBack(
        onShow: () {
          // print("插屏广告显示");
          uInteractionCallBack?.onShow!(UniversalSdkKType.TENCENT);
        },
        onClick: () {
          // print("插屏广告点击");
          uInteractionCallBack?.onClick!(UniversalSdkKType.TENCENT);
        },
        onFail: (code, message) {
          // print("插屏广告失败 $code $message");
          if (AdManage.instance.interstitialLoadBean.lastShowSuccess) {
            AdManage.instance.interstitialLoadBean.lastShowSuccess = false;
            AdManage.instance.loadInteractionAd(UniversalSdkKType.PANGOLIN);
          } else {
            uInteractionCallBack?.onFail!(
                UniversalSdkKType.TENCENT, code, message);
          }
        },
        onClose: () {
          // print("插屏广告关闭");
          uInteractionCallBack?.onClose!(UniversalSdkKType.TENCENT);
        },
        onReady: () async {
          // print("插屏广告预加载准备就绪");
          uInteractionCallBack?.onReady!(UniversalSdkKType.TENCENT);
        },
        onUnReady: () {
          print("2插屏广告预加载未准备就绪");
          uInteractionCallBack?.onUnReady!(UniversalSdkKType.TENCENT);
        },
      ),
    );

    FlutterUnionad.FlutterUnionadStream.initAdStream(
      //激励广告
      rewardAdCallBack: FlutterUnionad.RewardAdCallBack(
        onShow: () {
          // print("激励广告显示");
          uRewardCallBack?.onShow!(UniversalSdkKType.PANGOLIN);
        },
        onClick: () {
          // print("激励广告点击");
          uRewardCallBack?.onClick!(UniversalSdkKType.PANGOLIN);
        },
        onFail: (error) {
          // print("激励广告失败 $error");
          if (AdManage.instance.interstitialLoadBean.lastShowSuccess) {
            AdManage.instance.interstitialLoadBean.lastShowSuccess = false;
            AdManage.instance.loadInteractionAd(UniversalSdkKType.TENCENT);
          } else {
            uRewardCallBack?.onFail!(UniversalSdkKType.PANGOLIN, 0, error);
          }
        },
        onClose: () {
          // print("激励广告关闭");
          uRewardCallBack?.onClose!(UniversalSdkKType.PANGOLIN);
        },
        onSkip: () {
          // print("激励广告跳过");
        },
        onReady: () async {
          // print("激励广告预加载准备就绪");
          uRewardCallBack?.onReady!(UniversalSdkKType.PANGOLIN);
        },
        onUnReady: () {
          // print("激励广告预加载未准备就绪");
          uRewardCallBack?.onUnReady!(UniversalSdkKType.PANGOLIN);
        },
        onVerify: (rewardVerify, rewardAmount, rewardName) {
          // print("激励广告奖励  $rewardVerify   $rewardAmount  $rewardName");
          uRewardCallBack?.onVerify!(UniversalSdkKType.PANGOLIN, "",
              rewardVerify, rewardAmount, rewardName);
        },
      ),
      // 新模板渲染插屏广告回调
      fullScreenVideoAdInteractionCallBack:
          FlutterUnionad.FullScreenVideoAdInteractionCallBack(
        onShow: () {
          // print("新模板渲染插屏广告显示");
          uInteractionCallBack?.onShow!(UniversalSdkKType.PANGOLIN);
        },
        onSkip: () {
          // print("新模板渲染插屏广告跳过");
        },
        onClick: () {
          // print("新模板渲染插屏广告点击");
          uInteractionCallBack?.onClick!(UniversalSdkKType.PANGOLIN);
        },
        onFinish: () {
          // print("新模板渲染插屏广告结束");
        },
        onFail: (error) {
          // print("新模板渲染插屏广告错误 $error");
          if (AdManage.instance.interstitialLoadBean.lastShowSuccess) {
            AdManage.instance.interstitialLoadBean.lastShowSuccess = false;
            AdManage.instance.loadInteractionAd(UniversalSdkKType.TENCENT);
          } else {
            uInteractionCallBack?.onFail!(UniversalSdkKType.PANGOLIN, 0, error);
          }
        },
        onClose: () {
          // print("新模板渲染插屏广告关闭");
          uInteractionCallBack?.onClose!(UniversalSdkKType.PANGOLIN);
        },
        onReady: () async {
          // print("新模板渲染插屏广告预加载准备就绪");
          uInteractionCallBack?.onReady!(UniversalSdkKType.PANGOLIN);
        },
        onUnReady: () {
          print("1新模板渲染插屏广告预加载未准备就绪");
          uInteractionCallBack?.onUnReady!(UniversalSdkKType.PANGOLIN);
        },
      ),
    );
  }
}
