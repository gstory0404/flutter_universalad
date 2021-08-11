/// pangolinVersion : ""
/// tencentVersion : ""

class VersionEntity {
  String? pangolinVersion;
  String? tencentVersion;

  VersionEntity({
      this.pangolinVersion, 
      this.tencentVersion});

  VersionEntity.fromJson(dynamic json) {
    pangolinVersion = json["pangolinVersion"];
    tencentVersion = json["tencentVersion"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["pangolinVersion"] = pangolinVersion;
    map["tencentVersion"] = tencentVersion;
    return map;
  }



}