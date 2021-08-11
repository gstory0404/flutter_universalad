
import '../ad_code.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/11 5:29 下午
/// @Description: dart类作用描述 

class InterstitialLoadBean{
  String pangolinId = "";
  String tencentId = "";
  bool isFullScreen = true;
  int lastSdk = UniversalSdkKType.PANGOLIN; //上一次显示的广告sdk
  bool lastShowSuccess = true; //上一次加载广告是否成功
}