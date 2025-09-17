import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/location_data.dart';
import 'package:pov2/data/services/users_data.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_body_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_header_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_location_admin.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final List<Map<String, dynamic>> visitData = VisitData().taskData;
  final List<Map<String, dynamic>> locationData = LocationData().data;

  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Dashboard Administrator',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        labelStyle: AppText.heading5,
                        indicator: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        indicatorPadding: const EdgeInsets.all(AppSpacing.xxs),
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        tabs: const <Widget>[
                          Tab(
                            text: 'Ringkasan',
                          ),
                          Tab(
                            text: 'Jadwal Kunjungan',
                          ),
                          Tab(
                            text: 'Lokasi',
                          ),
                          Tab(
                            text: 'Pengguna',
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _resume(),
                        _schedule(),
                        _location(),
                        _users()
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  Widget _resume(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.sm,),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: CustomCardHeaderResume(
                      title: 'Total Pengguna',
                      icon: Icons.person_outline,
                      color: AppColor.accentMedium,
                      number: '4',
                      description: 'Petugas lapangan aktif'
                  ),
                ),
                SizedBox(width: AppSpacing.xs,),
                Expanded(
                  child: CustomCardHeaderResume(
                      title: 'Lokasi',
                      icon: Icons.location_on_outlined,
                      color: AppColor.accentCompleted,
                      number: '2',
                      description: 'Situs Terdaftar'
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: CustomCardHeaderResume(
                    title: 'Kunjungan Hari Ini',
                    icon: Icons.date_range_rounded,
                    color: AppColor.accentCompletion,
                    number: '1/2',
                    description: 'Selesai/Terjadwal'
                ),
              ),
              SizedBox(width: AppSpacing.xs,),
              Expanded(
                child: CustomCardHeaderResume(
                    title: 'Rata-rata Skor PoV',
                    icon: Icons.trending_up,
                    color: AppColor.accentHigh,
                    number: '92/100',
                    description: 'Bulan ini'
                ),
              )
            ],
          ),
          SizedBox(height:  AppSpacing.sm),
          _resume_schedule(),
          SizedBox(height:  AppSpacing.sm),
          _resume_new(),
          SizedBox(height:  AppSpacing.sm),
        ],
      ),
    );
  }

  Widget _resume_schedule(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal Hari Ini',
                style: AppText.heading4,
              ),
              Text(
                'Penugasan kunjungan saat ini',
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    ...visitData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(id: entry.key, data: data),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _resume_new(){
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aktifitas Terbaru',
                style: AppText.heading4,
              ),
              Text(
                'Penyelesaian Kunjungan Terkini',
                style: AppText.caption,
              ),
              Divider(),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    ...visitData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(id: entry.key, data: data, isNewActivity: true,),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _schedule(){
    return ListView(
      children: [
        SizedBox(height: AppSpacing.sm,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jadwal Kunjungan',
              style: AppText.heading2,
            ),
            CustomButton(
                textStyle: AppText.heading4Tertiary,
                title: 'Buat Jadwal',
                backgroundColor: AppColor.primary,
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                onPressed: (){},
                iconColor: AppColor.textTertiary,
                icon: Icons.add,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.border, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: WidgetStateProperty.all(AppColor.background),
                dividerThickness: 0.8,
                columns: const [
                  DataColumn(label: Text("Lokasi", style: AppText.heading4Secondary,)),
                  DataColumn(label: Text("Ditugaskan Kepada", style: AppText.heading4Secondary)),
                  DataColumn(label: Text("Tanggal", style: AppText.heading4Secondary)),
                  DataColumn(label: Text("Waktu", style: AppText.heading4Secondary)),
                  DataColumn(label: Text("Prioritas", style: AppText.heading4Secondary)),
                  DataColumn(label: Text("Status", style: AppText.heading4Secondary)),
                ],
                rows: VisitData().taskData.map((e)=>DataRow(cells: _buildScheduleVisitCells(e))).toList()
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataCell> _buildScheduleVisitCells(Map<String, dynamic> data) {
    return [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["place"] ?? ""
              ),
              Text(
                '${data["street"]}, ${data['city']}',
                style: AppText.caption,
              ),
            ],
          ),
        ),
      ),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data["person"] ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data["deadline"] ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text('${data["hourFrom"]}-${data['hourTo']}' ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child:
          CustomHighlightDashboard(
              title: data['status'],
              fontColor: ParsingColor.cekColor(data['status'])[0],
              containerColor: ParsingColor.cekColor(data['status'])[1]
          )

      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: CustomHighlightDashboard(
            title: data['statusJadwal'],
            fontColor: ParsingColor.cekColor(data['statusJadwal'])[0],
            containerColor: ParsingColor.cekColor(data['statusJadwal'])[1]
        )
      )),
    ];
  }

  Widget _location(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.sm,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lokasi',
                style: AppText.heading2,
              ),
              CustomButton(
                  textStyle: AppText.heading4Tertiary,
                  title: 'Tambah Lokasi',
                  backgroundColor: AppColor.accentCompletion,
                  padding: EdgeInsets.all(AppSpacing.xxs),
                  onPressed: (){},
                  icon: Icons.add,
                  iconColor: AppColor.textTertiary,
              )
            ],
          ),
          SizedBox(height: AppSpacing.sm,),
          ListView(
            shrinkWrap: true,
            children: [
              ...locationData.asMap().entries.map((entry){
                final data = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCardLocationAdmin(
                      id : entry.key,
                      data: data
                  ),
                );
              })

            ],
          )
        ]
      )
    );
  }

  Widget _users(){
    return ListView(
      children: [
        SizedBox(height: AppSpacing.sm,),
        Text(
          'Pengguna',
          style: AppText.heading2,
        ),
        SizedBox(height: AppSpacing.sm,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.border, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columnSpacing: 24,
                  headingRowColor: WidgetStateProperty.all(AppColor.background),
                  dividerThickness: 0.8,
                  columns: const [
                    DataColumn(label: Text("Nama", style: AppText.heading4Secondary,)),
                    DataColumn(label: Text("Email", style: AppText.heading4Secondary)),
                    DataColumn(label: Text("Peran", style: AppText.heading4Secondary)),
                    DataColumn(label: Text("ID Karyawan", style: AppText.heading4Secondary)),
                    DataColumn(label: Text("Status", style: AppText.heading4Secondary)),
                    DataColumn(label: Text("bergabung", style: AppText.heading4Secondary)),
                  ],
                  rows: UsersData().data.map((e)=>DataRow(cells: _buildUsersCells(e))).toList()
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataCell> _buildUsersCells(Map<String, dynamic> data) {
    return [
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data["name"] ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data["email"] ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data["role"] ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data['id']),
      )),
      DataCell(Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child:
          CustomHighlightDashboard(
              title: data['status'],
              fontColor: ParsingColor.cekColor(data['status'])[0],
              containerColor: ParsingColor.cekColor(data['status'])[1]
          )

      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data['join']),
      )),
    ];
  }
}
