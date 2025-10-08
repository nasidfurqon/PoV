import 'dart:ui';

import '../../config/theme/app_color.dart';

class ParsingColor{
  static List<Color> cekColor(String status) {
    if (status == 'high' || status == 'tinggi' || status == 'Non Active'|| status == 'Menunggu' || status == 'Maintenance' || status == 'Rating' || status  == 'Scheduled') {
      return [AppColor.accentHigh, AppColor.onAccentHigh];
    } else if (status == 'PDF' || status == 'normal' || status == 'PoV Score' || status == 'Ongoing' || status == 'Berlangsung' || status == 'Sedang' || status =='Total Lokasi' || status == 'Dokumen' || status == 'Total Kunjungan' || status == 'Proses' || status == 'Process') {
      return [AppColor.accentMedium, AppColor.onAccentMedium];
    } else  if(status == 'Video' || status == 'MP4'){
      return [AppColor.accentCompletion, AppColor.onAccentCompletion];
    } else if(status == 'Terjadwal' || status == 'score'){
      return [AppColor.textPrimary, AppColor.border];
    }
    else {
      return [AppColor.accentCompleted, AppColor.onAccentCompleted];
    }
  }
}