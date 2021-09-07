import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tencentad/flutter_tencentad.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_universalad/ad_code.dart';
import 'package:flutter_universalad/ad_manage.dart';
import 'package:flutter_universalad/method_callback.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/16 4:11 下午
/// @Description: dart类作用描述

class NativeAdView extends StatefulWidget {
  final String pangolinId;
  final String tencentId;
  final double width;
  final double height;
  final int loadType;
  final double probability;
  final UNativeCallBack? callBack;

  const NativeAdView({
    Key? key,
    required this.pangolinId,
    required this.tencentId,
    required this.width,
    required this.height,
    required this.loadType,
    required this.probability,
    this.callBack,
  }) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
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
        UniversalAdType.NATIVE, widget.loadType, widget.probability);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AdManage.instance.nativeLoadBean.lastSdk = _type;
    if (!_isShowAd || _type == 0) {
      return Container();
    }
    if (_type == UniversalSdkKType.TENCENT) {
      return Container(
        child: FlutterTencentad.expressAdView(
          codeId: widget.tencentId,
          viewWidth: widget.width.toInt(),
          viewHeight: widget.height.toInt(),
          callBack: FlutterTencentadExpressCallBack(
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
        child: FlutterUnionad.nativeAdView(
          androidCodeId: widget.pangolinId,
          iosCodeId: widget.pangolinId,
          expressNum: 1,
          expressViewWidth: widget.width,
          expressViewHeight: widget.height,
          callBack: FlutterUnionadNativeCallBack(
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
