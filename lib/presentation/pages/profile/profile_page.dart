import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

  class ProfilePage extends StatelessWidget {
    const ProfilePage({super.key});

    @override
    Widget build(BuildContext context) {
      return CustomScaffold(
        body: AppLayout(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.global),
              child: ListView(
                children: [
                  _header(),
                  SizedBox(height: AppSpacing.sm,),
                  _card(),
                  SizedBox(height: AppSpacing.sm,),
                  _personalInformation(),
                  SizedBox(height: AppSpacing.sm,),
                  CustomButtonFull(
                      textStyle: AppText.captionTertiary,
                      title: 'Edit Profile',
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      onPressed: (){},
                      iconColor: AppColor.textTertiary,
                      icon: Icons.edit_note_outlined,
                  ),
                  CustomButtonFull(
                    textStyle: AppText.captionPrimary,
                    title: 'Ubah Password',
                    backgroundColor: AppColor.background,
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    borderSide: BorderSide(
                      color: AppColor.textPrimary,
                      width: 1
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxxl)
                ],
              )
            )
        ),
      );
    }

    Widget _header(){
      return CustomCard(
          gradient: LinearGradient(
            colors: [AppColor.onAccentHigh, AppColor.onAccentMedium],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.global),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children:[
                Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/icon.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Demo Administrator',
                        style: AppText.heading3,
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        'PTM-2024-001',
                        style: AppText.bodySecondary,
                      ),
                      SizedBox(height: AppSpacing.xs),
                      CustomHighlightDashboard(title: 'Administrator', fontColor: AppColor.primary, containerColor: AppColor.primaryTransparent)
                    ],
                  )
                ],),
                SizedBox(
                  width: 40,
                  child: CustomCard(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.edit_note_outlined)
                  ),
                )
              ]
            ),
          )
      );
    }

    Widget _card(){
      return Column(
        children: [
          CustomHeaderCard(number: '45', status: 'Total Kunjungan'),
          SizedBox(height: AppSpacing.sm,),
          CustomHeaderCard(number: '45', status: 'Tugas Selesai'),
          SizedBox(height: AppSpacing.sm,),
          CustomHeaderCard(number: '4.5', status: 'Rating'),
        ],
      );
    }
  
    Widget _personalInformation(){
      return CustomCard(
          padding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.global),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Personal',
                  style: AppText.heading4,
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.email_outlined,
                    color: AppColor.textSecondary,
                    title: 'Email: admin@gmail.com',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.phone_outlined,
                    color: AppColor.textSecondary,
                    title: 'Telephone: +6200001010',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.location_on_outlined,
                    color: AppColor.textSecondary,
                    title: 'Lokasi: Jakarta, Indonesia',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.date_range_outlined,
                    color: AppColor.textSecondary,
                    title: 'Bergabung: 15/6/2024',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.military_tech_outlined,
                    color: AppColor.textSecondary,
                    title: 'Departemen: Operasional',
                    textStyle: AppText.caption
                ),
              ],
            ),
          )
      );
    }
  }
