import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_universalad/ad_manage.dart';
import 'package:flutter_universalad/flutter_universalad.dart';

import '../ad_code.dart';
import '../method_callback.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 9:47 上午
/// @Description: dart类作用描述

class BannerAdView extends StatefulWidget {
  final String pAndroidId;
  final String pIosId;
  final String tAndroidId;
  final String tIosId;
  final double width;
  final double height;
  final int loadType;
  final double probability;
  final UBannerCallBack? callBack;

  const BannerAdView(
      {Key? key,
      required this.pAndroidId,
      required this.pIosId,
      required this.tAndroidId,
      required this.tIosId,
      required this.width,
      required this.height,
      this.callBack,
      required this.loadType,
      required this.probability})
      : super(key: key);

  @override
  _BannerAdViewState createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
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
        UniversalAdType.BANNER, widget.loadType, widget.probability);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AdManage.instance.bannerLoadBean.lastSdk = _type;
    if (!_isShowAd || _type == 0) {
      return Container();
    }
    if (_type == UniversalSdkKType.TENCENT) {
      return Container(
        child: FlutterTencentad.bannerAdView(
          androidId: widget.tAndroidId,
          iosId: widget.tIosId,
          viewWidth: widget.width,
          viewHeight: widget.height,
          callBack: FlutterTencentadBannerCallBack(
            onShow: () {
              widget.callBack?.onShow!(UniversalSdkKType.TENCENT);
            },
            onFail: (code, message) {
              if (isLoadSuccess) {
                setState(() {
                  isLoadSuccess = false;
                  _type = UniversalSdkKType.PANGOLIN;
                });
              } else {
                widget.callBack?.onFail!(
                    UniversalSdkKType.TENCENT, code, message);
                setState(() {
                  _isShowAd = false;
                });
              }
            },
            onClose: () {
              widget.callBack?.onClose!(UniversalSdkKType.TENCENT);
            },
            onClick: () {
              widget.callBack?.onClick!(UniversalSdkKType.TENCENT);
            },
          ),
        ),
      );
    } else {
      return Container(
        child: FlutterUnionad.bannerAdView(
          androidCodeId: widget.pAndroidId,
          iosCodeId: widget.pIosId,
          expressAdNum: 1,
          expressViewWidth: widget.width,
          expressViewHeight: widget.height,
          callBack: FlutterUnionadBannerCallBack(
            onShow: () {
              widget.callBack?.onShow!(UniversalSdkKType.PANGOLIN);
            },
            onClick: () {
              widget.callBack?.onClick!(UniversalSdkKType.PANGOLIN);
            },
            onDislike: (message) {
              widget.callBack?.onClose!(UniversalSdkKType.PANGOLIN);
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
          ),
        ),
      );
    }
  }
}
