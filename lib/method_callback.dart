/// @Author: gstory
/// @CreateDate: 2021/8/11 12:25 下午
/// @Description: dart类作用描述

///穿山甲广告
typedef PangolinInit = void Function(bool result);

///优量汇广告
typedef TencentInit = void Function(bool result);

class RegisterCallBack {
  PangolinInit? pangolinInit;
  TencentInit? tencentInit;

  RegisterCallBack({this.pangolinInit, this.tencentInit});
}

///显示
typedef UOnShow = void Function(int sdkType);

///失败
typedef UOnFail = void Function(int sdkType, int code, dynamic message);

///点击
typedef UOnClick = void Function(int sdkType);

///关闭
typedef UOnClose = void Function(int sdkType);

///广告预加载完成
typedef UOnReady = void Function(int sdkType);

///广告预加载未完成
typedef UOnUnReady = void Function(int sdkType);

///广告奖励验证
typedef UOnVerify = void Function(
    int sdkType, String transId, bool verify, int amount, String name);

///
/// 激励广告回调
///
class URewardCallBack {
  UOnShow? onShow;
  UOnClose? onClose;
  UOnClick? onClick;
  UOnFail? onFail;
  UOnReady? onReady;
  UOnUnReady? onUnReady;
  UOnVerify? onVerify;

  URewardCallBack({
    this.onShow,
    this.onClose,
    this.onClick,
    this.onFail,
    this.onReady,
    this.onUnReady,
    this.onVerify,
  });
}

///
/// 插屏广告回调
///
class UInteractionCallBack {
  UOnShow? onShow;
  UOnClose? onClose;
  UOnClick? onClick;
  UOnFail? onFail;
  UOnReady? onReady;
  UOnUnReady? onUnReady;

  UInteractionCallBack({
    this.onShow,
    this.onClose,
    this.onClick,
    this.onFail,
    this.onReady,
    this.onUnReady,
  });
}

///
///banner广告回调
///
class UBannerCallBack {
  UOnShow? onShow;
  UOnFail? onFail;
  UOnClose? onClose;
  UOnClick? onClick;

  UBannerCallBack({this.onShow, this.onFail, this.onClose, this.onClick});
}

///
///信息流广告回调
///
class UNativeCallBack {
  UOnShow? onShow;
  UOnFail? onFail;
  UOnClose? onClose;
  UOnClick? onClick;

  UNativeCallBack({this.onShow, this.onFail, this.onClose, this.onClick});
}

///
/// 开屏广告回调
///
class USplashCallBack {
  UOnShow? onShow;
  UOnFail? onFail;
  UOnClose? onClose;
  UOnClick? onClick;

  USplashCallBack({this.onShow, this.onFail, this.onClose, this.onClick});
}
