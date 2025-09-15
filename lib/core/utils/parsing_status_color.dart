import 'dart:ui';

import '../../config/theme/app_color.dart';

class ParsingColor{
  static List<Color> cekColor(String status) {
    if (status == 'high' || status == 'tinggi' || status == 'Menunggu') {
      return [AppColor.accentHigh, AppColor.onAccentHigh];
    } else if (status == 'normal' || status == 'Berlangsung' || status == 'Sedang') {
      return [AppColor.accentMedium, AppColor.onAccentMedium];
    } else {
      return [AppColor.accentCompleted, AppColor.onAccentCompleted];
    }
  }
}