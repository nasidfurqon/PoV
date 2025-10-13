import 'package:flutter/material.dart';
import 'package:pov2/config/router/app_routes.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_layout.dart';
import 'package:pov2/core/widget/custom_scaffold.dart';
import 'package:pov2/data/models/mtUserPosition_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
  class ProfilePage extends StatefulWidget {
    const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    MTUserModel? userData;
    int completedVisitation = 0;
    int totalVisitation = 0;
    MTUserPositionModel? userPositionData;
    bool isLoading = true;

    late SharedPreferences pref;
    @override
    void initState(){
      super.initState();
      _loadData();
    }

    Future<void> _loadData() async{
      pref = await SharedPreferences.getInstance();
      MTUserModel? data = await GetService.getUser(pref.getString('userId'));
      MTUserPositionModel? posData = await GetService.getUserPosition(data?.mtUserPositionId);
      var temp = await CountService.countStatus('Completed', pref.getString('userId'));
      var temp2 = await CountService.countTotalVisitation();
      setState(() {
        userData = data;
        userPositionData = posData;
        completedVisitation = temp;
        totalVisitation = temp2;
        isLoading = false;
      });
    }

    @override
    Widget build(BuildContext context) {
      return CustomScaffold(
        body: AppLayout(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.global),
              child: isLoading ?
              Center(child: CircularProgressIndicator()) : ListView(
                children: [
                  _header(),
                  SizedBox(height: AppSpacing.sm,),
                  _card(),
                  SizedBox(height: AppSpacing.sm,),
                  _personalInformation(),
                  SizedBox(height: AppSpacing.sm,),
                  CustomButtonFull(
                      textStyle: AppText.heading5Tertiary,
                      title: 'Edit Profile',
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      onPressed: (){},
                      iconColor: AppColor.textTertiary,
                      icon: Icons.edit_note_outlined,
                  ),
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
                  ),
                  CustomButtonFull(
                    textStyle: AppText.heading5Tertiary,
                    title: 'Logout',
                    icon: Icons.logout,
                    iconColor: AppColor.textTertiary,
                    backgroundColor: AppColor.primary,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      context.goNamed(AppRoutes.login.name);
                    },
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
                        userData?.employeeId ?? '',
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
          CustomHeaderCard(number: totalVisitation.toString(), status: 'Total Kunjungan'),
          SizedBox(height: AppSpacing.sm,),
          CustomHeaderCard(number: completedVisitation.toString(), status: 'Tugas Selesai'),
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
                    title: 'Email: ${userData?.email ?? ''}',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.phone_outlined,
                    color: AppColor.textSecondary,
                    title: 'Telephone: ${userData?.email}',
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
                    title: 'Bergabung: ${ParsingHelper.splitTimePre(userData?.createdDateTime)}',
                    textStyle: AppText.caption
                ),
                SizedBox(height: AppSpacing.xs,),
                CustomRowIcon(
                    icon: Icons.military_tech_outlined,
                    color: AppColor.textSecondary,
                    title: 'Departemen: ${userPositionData?.organizationName}',
                    textStyle: AppText.caption
                ),
              ],
            ),
          )
      );
    }
}
