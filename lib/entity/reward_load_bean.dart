import 'package:flutter_universalad/ad_code.dart';

/// @Author: gstory
/// @CreateDate: 2021/8/11 3:28 下午
/// @Description: 激励广告加载相关参数

class RewardLoadBean {
  String pAndroidId = "";
  String pIosId = "";
  String tAndroidId = "";
  String tIosId = "";
  String rewardName = "";
  int rewardAmount = 0;
  String userID = "";
  String customData ="";
  int loadType = 0;
  double probability = 0.0;
  int lastSdk = UniversalSdkKType.PANGOLIN; //上一次显示的广告sdk
  bool lastShowSuccess = true; //上一次加载广告是否成功
}
