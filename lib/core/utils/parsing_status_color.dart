import 'dart:ui';

import '../../config/theme/app_color.dart';

class ParsingColor{
  static List<Color> cekColor(String status) {
    if (status == 'high' || status == 'tinggi' || status == 'Menunggu' || status == 'Maintenance' || status == 'Rating') {
      return [AppColor.accentHigh, AppColor.onAccentHigh];
    } else if (status == 'PDF' || status == 'normal' || status == 'Berlangsung' || status == 'Sedang' || status =='Total Lokasi' || status == 'Dokumen' || status == 'Total Kunjungan' || status == 'Proses') {
      return [AppColor.accentMedium, AppColor.onAccentMedium];
    } else  if(status == 'Video' || status == 'MP4'){
      return [AppColor.accentCompletion, AppColor.onAccentCompletion];
    }
    else {
      return [AppColor.accentCompleted, AppColor.onAccentCompleted];
    }
  }
}