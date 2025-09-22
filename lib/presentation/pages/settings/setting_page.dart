import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_dropdown.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/services/dropdown_data.dart';

import '../../../core/widget/custom_switch.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppLayout(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _notification(),
                SizedBox(height: AppSpacing.sm,),
                _keamanan(),
                SizedBox(height: AppSpacing.sm,),
                _aplikasi(),
                SizedBox(height: AppSpacing.sm,),
                _bahasa(),
                SizedBox(height: AppSpacing.sm,),
                _data(),
                SizedBox(height: AppSpacing.sm,),
                _bantuan(),
                SizedBox(height: AppSpacing.xxxl,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String title, IconData icon){
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          title,
          style: AppText.heading3,
        )
      ],
    );
  }

  Widget _body(String title, String description, bool isShow){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppText.body,
            ),
            Text(
              description,
              style: AppText.caption,
            ),
          ],
        ),
        if(isShow == true)
        CustomSwitch(
          initialValue: isEnabled,
          onChanged: (value) {
            setState(() {
              isEnabled = value;
            });
          },
          activeColor: AppColor.primary,
          inactiveColor: AppColor.primaryTransparent,
        ),
      ],
    );
  }

  Widget _notification(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Notifikasi', Icons.notifications_none_outlined),
              SizedBox(height: AppSpacing.sm,),
              _body('Push Notifications', 'Terima notifikasi tugas baru', true),
              SizedBox(height: AppSpacing.xs,),
              _body('Email Notifications', 'Laporan harian via email', true),
              SizedBox(height: AppSpacing.xs,),
              _body('SMS Alerts', 'Peringatan darurat via SMS', false)
            ],
          ),
        )
    );
  }

  Widget _keamanan(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Keamanan', Icons.shield_outlined),
              SizedBox(height: AppSpacing.sm,),
              _body('Two-Factor Authentication', 'Keamanan tambahan untuk login', false),
              SizedBox(height: AppSpacing.xs,),
              _body('Biometric Login', 'Login dengan sidik jari', true),
              SizedBox(height: AppSpacing.xs,),
              CustomButtonFull(
                  textStyle: AppText.heading5,
                  title: 'Ubah Password',
                  backgroundColor: AppColor.background,
                  padding: EdgeInsets.zero,
                  onPressed: (){},
                  borderSide: BorderSide(
                    color: AppColor.textPrimary,
                    width: 1
                  ),
              )
            ],
          ),
        )
    );
  }

  Widget _aplikasi(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Aplikasi', Icons.phone_android),
              SizedBox(height: AppSpacing.sm,),
              _body('Mode Gelap', 'Tampilan gelap untuk mata', false),
              SizedBox(height: AppSpacing.xs,),
              _body('Auto Sync', 'Sinkronisasi otomatis data', true),
              SizedBox(height: AppSpacing.xs,),
              _body('Offline Mode', 'Simpan data saat offline', true)
            ],
          ),
        )
    );
  }

  Widget _bahasa(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Bahasa & Region', Icons.language_outlined),
              SizedBox(height: AppSpacing.sm,),
              CustomDropdown(
                  title: 'Bahasa: ',
                  items: DropdownData.languange,
                  initialValue: '1',
                  onChanged:(value){
                  }
              ),
              SizedBox(height: AppSpacing.xs),
              CustomDropdown(
                  title: 'Zona Waktu: ',
                  items: DropdownData.timeZone,
                  initialValue: '1',
                  onChanged:(value){
                  }
              )
            ],
          ),
        )
    );
  }

  Widget _data(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Data & Storage', Icons.storage_sharp),
              SizedBox(height: AppSpacing.sm,),
              CustomButtonFull(
                  textStyle: AppText.heading5,
                  title: 'Bersihkan Cache',
                  backgroundColor: AppColor.background,
                  padding: EdgeInsets.zero,
                  onPressed: (){},
                  borderSide: BorderSide(
                    color: AppColor.textPrimary,
                    width: 1
                  ),
              ),
              SizedBox(height: AppSpacing.xs),
              CustomButtonFull(
                  textStyle: AppText.heading5,
                  title: 'Export Data',
                  backgroundColor: AppColor.background,
                  padding: EdgeInsets.zero,
                  onPressed: (){},
                  borderSide: BorderSide(
                      color: AppColor.textPrimary,
                      width: 1
                  ),
              ),
              SizedBox(height: AppSpacing.xs),
              CustomButtonFull(
                textStyle: AppText.heading5Tertiary,
                title: 'Reset Aplikasi',
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.zero,
                onPressed: (){},
              ),
            ],
          ),
        )
    );
  }

  Widget _bantuan(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global ),
          child: Column(
            children: [
              _title('Bantuan & Dukungan', Icons.question_mark_rounded),
              SizedBox(height: AppSpacing.sm,),
              CustomDropdown(
                  title: 'FAQ ',
                  items: DropdownData.nullData,
                  initialValue: '1',
                  onChanged:(value){
                  }
              ),
              SizedBox(height: AppSpacing.xs),
              CustomDropdown(
                  title: 'Hubungi Support ',
                  items: DropdownData.nullData,
                  initialValue: '1',
                  onChanged:(value){
                  }
              ),
              SizedBox(height: AppSpacing.xs),
              CustomDropdown(
                  title: 'tentang Aplikasi ',
                  items: DropdownData.nullData,
                  initialValue: '1',
                  onChanged:(value){
                  }
              )
            ],
          ),
        )
    );
  }
}
