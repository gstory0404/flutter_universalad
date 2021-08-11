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
typedef OnShow = void Function(int sdkType);

///失败
typedef OnFail = void Function(int sdkType, int code, dynamic message);

///点击
typedef OnClick = void Function(int sdkType);

///关闭
typedef OnClose = void Function(int sdkType);

///广告预加载完成
typedef OnReady = void Function(int sdkType);

///广告预加载未完成
typedef OnUnReady = void Function(int sdkType);

///广告奖励验证
typedef OnVerify = void Function(
    int sdkType, String transId, bool verify, int amount, String name);

class URewardCallBack {
  OnShow? onShow;
  OnClose? onClose;
  OnClick? onClick;
  OnFail? onFail;
  OnReady? onReady;
  OnUnReady? onUnReady;
  OnVerify? onVerify;

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

class UInteractionCallBack {
  OnShow? onShow;
  OnClose? onClose;
  OnClick? onClick;
  OnFail? onFail;
  OnReady? onReady;
  OnUnReady? onUnReady;

  UInteractionCallBack({
    this.onShow,
    this.onClose,
    this.onClick,
    this.onFail,
    this.onReady,
    this.onUnReady,
  });
}
