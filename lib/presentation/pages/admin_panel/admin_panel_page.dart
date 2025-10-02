import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_date_picker.dart';
import 'package:pov2/core/widget/custom_dropdown.dart';
import 'package:pov2/core/widget/custom_modal_dialog.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_textfield.dart';
import 'package:pov2/core/widget/custom_time_field.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/get_admin_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/data/services/location_data.dart';
import 'package:pov2/data/services/users_data.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/presentation/widgets/custom_card_body_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_header_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_location_admin.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import '../../../data/models/trVisitationSchedule_model.dart';
import '../../../data/models/dropdown_model.dart';
import '../../../data/services/dropdown_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  List<TRVisitationScheduleModel> scheduleData = [];
  List<TRVisitationScheduleModel> scheduleCompletedData = [];
  List<TRVisitationScheduleModel> visitedData = [];
  List<MTLocationModel> locationData = [];
  List<MTUserModel> userData = [];
  final List<String> person = UsersData().data.map((e) => e['name'] as String).toList();
  // late final List<String> location = locationData.map((e) => e['place'] as String).toList();
  late SharedPreferences pref;
  late final List<DropdownItemModel> personDropdown = person.asMap().entries.map((entry) {
    final index = entry.key;
    final name = entry.value;
    return DropdownItemModel(
      id: (index + 1).toString(),
      label: name,
    );
  }).toList();

  int cntUser = 0;
  int cntLocation = 0;
  int cntVisitationToday = 0;
  int cntVisitationTodayCompleted = 0;
  // late final List<DropdownItemModel> locationDropdown = location.asMap().entries.map((entry) {
  //   final index = entry.key;
  //   final name = entry.value;
  //   return DropdownItemModel(
  //     id: (index + 1).toString(),
  //     label: name,
  //   );
  // }).toList();

  String? selectedAssignValue;
  String? selectedLocationValue;
  String? selectedPriorityValue;
  String? selectedTypeLocationValue;

  @override
  void initState(){
    super.initState();
    _loadData();
    _loadCountData();
  }

  Future<void> _loadCountData() async{
    int temp1 = await CountService.countAdminUser();
    int temp2 = await CountService.countAdminLocation();
    int temp3 = await CountService.countAdminScheduleToday();
    int temp4 = await CountService.countAdminScheduleTodayCompleted();
    setState(() {
      cntUser = temp1;
      cntLocation = temp2 ;
      cntVisitationToday = temp3;
      cntVisitationTodayCompleted = temp4;
    });
  }
  Future<void> _loadData() async{
    pref = await SharedPreferences.getInstance();
    List<TRVisitationScheduleModel> res = await GetAdminService.getListScheduleToday();
    List<TRVisitationScheduleModel> resComp = await GetAdminService.getListScheduleTodayCompleted();
    List<TRVisitationScheduleModel> resSche = await GetAdminService.getListSchedule();
    List<MTLocationModel> loc = await GetAdminService.getListLocation();
    List<MTUserModel> user = await GetAdminService.getListUser();
    setState(() {
      scheduleData = res  ;
      scheduleCompletedData = resComp;
      visitedData = resSche;
      locationData = loc;
      userData = user;
    });
  }
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
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _resume(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _schedule(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _location(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _users(),
                        ),
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
                      number: cntUser.toString(),
                      description: 'Petugas lapangan aktif'
                  ),
                ),
                SizedBox(width: AppSpacing.xs,),
                Expanded(
                  child: CustomCardHeaderResume(
                      title: 'Lokasi',
                      icon: Icons.location_on_outlined,
                      color: AppColor.accentCompleted,
                      number: cntLocation.toString(),
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
                    number: '${cntVisitationTodayCompleted}/${cntVisitationToday}',
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.onAccentMedium,
            AppColor.onAccentMedium.withOpacity(0.4),
            AppColor.onAccentMedium.withOpacity(0.1),
            Colors.transparent,
          ],
          stops: const [0.0, 0.1, 0.2, 0.3],
        ),
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
                    ...scheduleData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(
                          id: entry.key,
                          score: 0,
                          hourFrom: ParsingHelper.splitTimePost(data.startDateTime),
                          status: data.status ?? '', 
                          name: GetService.getLocationbyID(data.mtLocationId).then((data)=>data?.name),
                          person: GetService.name(data.mtAssignedUserId),
                        ),
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.onAccentCompleted,
            AppColor.onAccentCompleted.withOpacity(0.4),
            AppColor.onAccentCompleted.withOpacity(0.1),
            Colors.transparent,
          ],
          stops: const [0.0, 0.1, 0.2, 0.3],
        ),
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
                    ...scheduleCompletedData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(
                          id: entry.key,
                          score: 0,
                          isNewActivity: true,
                          hourFrom: ParsingHelper.splitTimePost(data.startDateTime),
                          status: data.status ?? '',
                          actEndDateTime: ParsingHelper.splitTimePre(data.actualEndDateTime),
                          name: GetService.getLocationbyID(data.mtLocationId).then((data)=>data?.name),
                          person: GetService.name(data.mtAssignedUserId),
                        ),
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
                onPressed: (){
                  CustomModelDialog.show(
                    context,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          'Buat Jadwal Kunjungan Baru',
                          style: AppText.heading3,
                        ),
                        Text(
                          maxLines: 2,
                          'Tugaskan kunjungan kepada petugas lapangan',
                          style: AppText.caption,
                        )
                      ],
                    ),
                    _formSchedule()
                  );
                },
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
                rows: visitedData.map((e)=>DataRow(cells: _buildScheduleVisitCells(e))).toList()
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataCell> _buildScheduleVisitCells(TRVisitationScheduleModel data) {
    return [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<MTLocationModel?>(
                future: GetService.getLocationbyID(data.mtLocationId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("...");
                  } else if (snapshot.hasError) {
                    return const Text('');
                  } else {
                    return Text(
                      snapshot.data?.name ?? ''
                    );
                  }
                },),
              FutureBuilder<MTLocationModel?>(
                future: GetService.getLocationbyID(data.mtLocationId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("...");
                  } else if (snapshot.hasError) {
                    return const Text('');
                  } else {
                    return Text(
                        snapshot.data?.address ?? '',
                      style: AppText.caption,
                    );
                  }
                },),
            ],
          ),
        ),
      ),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: FutureBuilder<String?>(
          future: GetService.name(data.mtAssignedUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("...");
            } else if (snapshot.hasError) {
              return const Text('');
            } else {
              return Text(
                snapshot.data ?? '',
              );
            }
          },),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(ParsingHelper.splitTimePre(data.endDateTime) ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text('${ParsingHelper.splitTimePost(data.startDateTime)}-${ParsingHelper.splitTimePost(data.endDateTime)}' ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child:
          CustomHighlightDashboard(
              title: data.priority ?? '',
              fontColor: ParsingColor.cekColor(data.priority ?? '')[0],
              containerColor: ParsingColor.cekColor(data.priority ?? '')[1]
          )
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: CustomHighlightDashboard(
            title: data.status ?? '',
            fontColor: ParsingColor.cekColor(data.status ?? '')[0],
            containerColor: ParsingColor.cekColor(data.status ?? '')[1]
        )
      )),
    ];
  }

  Widget _formSchedule(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownWithLabel(
          label: 'Assign To',
          items: personDropdown,
          initialValue: '1' ?? '',
          onChanged: (value){
            setState(() {
              selectedAssignValue = value;
            });
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Location',
          items: [],
          initialValue: '1' ?? '',
          onChanged: (value){
            setState(() {
              selectedLocationValue = value;
            });
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDatePicker(
            label: 'Date',
            controller: TextEditingController()
        ),
        SizedBox(height: AppSpacing.xs,),
        Row(
          children: [
            Expanded(
              child: CustomTimeField(
                  label: 'Start Time',
                  controller: TextEditingController()
              ),
            ),
            SizedBox(width: AppSpacing.xs,),
            Expanded(
              child: CustomTimeField(
                  label: 'End Time',
                  controller: TextEditingController()
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Priority',
          items: DropdownData.priorityData,
          initialValue: '1' ?? '',
          onChanged: (value){
            setState(() {
              selectedPriorityValue = value;
            });
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
            label: 'Visit Purpose',
            maxLines: 3,
            hint: 'Describe the purpose of this visit',
            keyboardType: TextInputType.multiline,
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Create Schedule',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.zero,
            onPressed: (){}
        )
      ],
    );
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
                  backgroundColor: AppColor.primary,
                  padding: EdgeInsets.all(AppSpacing.xxs),
                  onPressed: (){
                    CustomModelDialog.show(
                        context,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              'Tambah Lokasi Baru',
                              style: AppText.heading3,
                            ),
                            Text(
                              maxLines: 2,
                              'Daftarkan situs baru untuk kunjungan',
                              style: AppText.caption,
                            )
                          ],
                        ),
                        _formLocation()
                    );
                  },
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

  Widget _formLocation(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithLabel(
          label: 'Location Name',
          hint: 'Office Building A',
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Type',
          items: DropdownData.typeLocation,
          initialValue: '1' ?? '',
          onChanged: (value){
            setState(() {
              selectedTypeLocationValue = value;
            });
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
          label: 'Address',
          maxLines: 3,
          hint: 'Full address of the location',
          keyboardType: TextInputType.multiline,
        ),
        SizedBox(height: AppSpacing.xs,),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithLabel(
                label: 'Latitude',
                hint: '-6.2088',
              ),
            ),
            SizedBox(width: AppSpacing.xs,),
            Expanded(
              child: CustomTextFieldWithLabel(
                label: 'Longitude',
                hint: '-6.2088',
              ),
            )
          ],
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
          label: 'Geofence',
          hint: '100',
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
          label: 'Description',
          hint: 'Additional details about this location',
          maxLines: 3,
          keyboardType: TextInputType.multiline,
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Create Location',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.zero,
            onPressed: (){}
        )
      ],
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
                  rows: userData.map((e)=>DataRow(cells: _buildUsersCells(e))).toList()
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataCell> _buildUsersCells(MTUserModel data) {
    return [
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data.fullName ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data.email ?? ""),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text((data.mtUserLevelId ?? "").toString()),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(data.employeeId ?? ''),
      )),
      DataCell(Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child:
          CustomHighlightDashboard(
              title: (data.isActive ?? '').toString(),
              fontColor: ParsingColor.cekColor((data.isActive ?? '').toString())[0],
              containerColor: ParsingColor.cekColor((data.isActive ?? '').toString())[1]
          )

      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(ParsingHelper.splitTimePre(data.createdDateTime)),
      )),
    ];
  }
}
