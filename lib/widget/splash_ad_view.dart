import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_universalad/ad_manage.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 4:34 下午
/// @Description: dart类作用描述

class SplashAdView extends StatefulWidget {
  final String pangolinId;
  final String tencentId;
  final int loadType;
  final double probability;
  final USplashCallBack? callBack;

  const SplashAdView(
      {Key? key,
      required this.pangolinId,
      required this.tencentId,
      required this.loadType,
      required this.probability,
      required this.callBack})
      : super(key: key);

  @override
  _SplashAdViewState createState() => _SplashAdViewState();
}

class _SplashAdViewState extends State<SplashAdView> {
  //广告是否显示
  bool _isShowAd = true;

  //加载方式
  int _type = 0;

  //上次是否加载成功
  bool isLoadSuccess = true;

  @override
  void initState() {
    super.initState();
    _isShowAd = true;
    getType();
  }

  void getType() async {
    _type = await AdManage.instance.getLoadAdtype(
        UniversalAdType.SPLAH, widget.loadType, widget.probability);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AdManage.instance.splashLoadBean.lastSdk = _type;
    if (!_isShowAd || _type == 0) {
      return Container();
    }
    if (_type == UniversalSdkKType.TENCENT) {
      return Container(
        child: FlutterTencentad.splashAdView(
          //广告id
          codeId: widget.tencentId,
          ////设置开屏广告从请求到展示所花的最大时长（并不是指广告曝光时长），取值范围为[1500, 5000]ms
          fetchDelay: 3000,
          //广告回调
          callBack: FlutterTencentadSplashCallBack(
            onShow: () {
              widget.callBack?.onShow!(UniversalSdkKType.TENCENT);
            },
            onADTick: (time) {
              print("开屏广告倒计时剩余时间 $time");
            },
            onClick: () {
              widget.callBack?.onClick!(UniversalSdkKType.TENCENT);
            },
            onClose: () {
              widget.callBack?.onClose!(UniversalSdkKType.TENCENT);
            },
            onExpose: () {
              print("开屏广告曝光");
            },
            onFail: (code, message) {
              if (isLoadSuccess) {
                setState(() {
                  isLoadSuccess = false;
                  _type = UniversalSdkKType.PANGOLIN;
                });
              } else {
                widget.callBack?.onFail!(UniversalSdkKType.TENCENT, 0, message);
                setState(() {
                  _isShowAd = false;
                });
              }
            },
          ),
        ),
      );
    } else {
      return Container(
        child: FlutterUnionad.splashAdView(
          //是否使用个性化模版  设定widget宽高
          mIsExpress: true,
          //android 开屏广告广告id 必填
          androidCodeId: widget.pangolinId,
          //ios 开屏广告广告id 必填
          iosCodeId: widget.pangolinId,
          //是否支持 DeepLink 选填
          supportDeepLink: true,
          // 期望view 宽度 dp 选填 mIsExpress=true必填
          expressViewWidth: MediaQuery.of(context).size.width,
          //期望view高度 dp 选填 mIsExpress=true必填
          expressViewHeight: MediaQuery.of(context).size.height,
          callBack: FlutterUnionadSplashCallBack(
            onShow: () {
              widget.callBack?.onShow!(UniversalSdkKType.PANGOLIN);
            },
            onClick: () {
              widget.callBack?.onClick!(UniversalSdkKType.PANGOLIN);
            },
            onFail: (error) {
              if (isLoadSuccess) {
                setState(() {
                  isLoadSuccess = false;
                  _type = UniversalSdkKType.TENCENT;
                });
              } else {
                widget.callBack?.onFail!(UniversalSdkKType.PANGOLIN, 0, error);
                setState(() {
                  _isShowAd = false;
                });
              }
            },
            onFinish: () {
              widget.callBack?.onClose!(UniversalSdkKType.PANGOLIN);
            },
            onSkip: () {
              widget.callBack?.onClose!(UniversalSdkKType.PANGOLIN);
            },
            onTimeOut: () {
              widget.callBack?.onFail!(UniversalSdkKType.PANGOLIN, 0, "广告超时");
            },
          ),
        ),
      );
    }
  }
}
