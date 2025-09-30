class ParsingHelper{
  static int? parseInt(dynamic val) {
    if (val == null) return null;
    if (val is String) return int.tryParse(val);
    if (val is int) return val;
    return null;
  }

  static String splitTimePre(dynamic date) {
    return date.toString().split('T')[0];
  }

  static String splitTimePost(dynamic date) {
    return date.toString().split('T')[1];
  }


  static bool? parseBool(dynamic val) {
    if (val == null) return null;
    if (val is bool) return val;
    if (val is int) return val == 1;
    if (val is String) return val.toLowerCase() == "true" || val == "1";
    return null;
  }


}