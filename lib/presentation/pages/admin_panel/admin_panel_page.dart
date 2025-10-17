import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_helper.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_allert.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_date_picker.dart';
import 'package:pov2/core/widget/custom_date_time_picker.dart';
import 'package:pov2/core/widget/custom_dropdown.dart';
import 'package:pov2/core/widget/custom_modal_dialog.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_textfield.dart';
import 'package:pov2/core/widget/custom_time_field.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/data/models/mtLocationType_model.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/models/mtUser_model.dart';
import 'package:pov2/data/services/add_service.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/get_admin_service.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/data/services/location_data.dart';
import 'package:pov2/data/services/location_notifier.dart';
import 'package:pov2/data/services/users_data.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/data/services/visitation_notifier.dart';
import 'package:pov2/presentation/widgets/custom_card_body_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_header_resume.dart';
import 'package:pov2/presentation/widgets/custom_card_location_admin.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import '../../../core/widget/custom_progress_indicator.dart';
import '../../../data/models/mtVisitationPurpose_model.dart';
import '../../../data/models/trVisitationSchedule_model.dart';
import '../../../data/models/dropdown_model.dart';
import '../../../data/services/dropdown_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPanelPage extends ConsumerStatefulWidget {
  const AdminPanelPage({super.key});

  @override
  ConsumerState<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends ConsumerState<AdminPanelPage> {
  List<JobListModel> scheduleData = [];
  List<TRVisitationScheduleModel> scheduleCompletedData = [];
  // List<TRVisitationScheduleModel> visitedData = [];
  List<MTVisitationPurpose> visitationPurpose =[];
  List<MTLocationTypeModel> locationTypeData = [];
  List<MTLocationModel> locationData = [];
  List<MTUserModel> userData = [];
  late SharedPreferences pref;
  List<DropdownItemModel> personDropdown = [];
  List<DropdownItemModel> locationDropdown = [];
  List<DropdownItemModel> visitationPurposeDropdown = [];
  List<DropdownItemModel> locationTypeDropdown = [];
  late Map<String, TextEditingController> scheduleControllers;
  late Map<String, TextEditingController> locationControllers;
  late TRVisitationScheduleModel scheduleUpdatedData;
  late MTLocationModel locationUpdatedData;
  int cntUser = 0;
  int cntLocation = 0;
  int cntVisitationToday = 0;
  int cntVisitationTodayCompleted = 0;
  int cntTotalVisit = 0;
  int cntTotalCompleteVisit = 0;
  double povScore = 0;
  String? selectedAssignValue;
  String? selectedLocationValue;
  String? selectedPriorityValue;
  String? selectedTypeLocationValue;
  bool isLoading = true;
  @override
  void initState(){
    super.initState();
    _loadData();
    _loadCountData();
    scheduleControllers = {};
    locationControllers = {};
    Future.microtask((){
      setState(() {
        scheduleUpdatedData = TRVisitationScheduleModel();
        locationUpdatedData = MTLocationModel();
        _initializeControllers(scheduleUpdatedData, locationUpdatedData);
      });
    });
  }

  void _initializeControllers(TRVisitationScheduleModel sche, MTLocationModel loc) {
    final fields = [
      'MTAssignedUserID','MTLocationID', 'StartDateTime', 'EndDateTime', 'dateOfExpiry', 'Priority', 'VisitationDescription', 'Status',
      'CreatedByUserID', 'CreatedDateTime', 'LastUpdatedByUserID', 'LastUpdatedDateTime', 'MTVisitationPurposeID'
    ];

    for (var field in fields) {
      scheduleControllers[field] ??= TextEditingController();
      scheduleControllers[field]!.text = sche.toJson()[field] ?? '';
    }

    final fieldsLoc = [
      'Name','MTLocationTypeID', 'Address', 'Latitude', 'Longitude', 'GeoFence',
      'CreatedByUserID', 'CreatedDateTime', 'LastUpdatedByUserID', 'LastUpdatedDateTime'
    ];

    for (var field in fieldsLoc) {
      locationControllers[field] ??= TextEditingController();
      locationControllers[field]!.text = sche.toJson()[field] ?? '';
    }
  }

  Future<void> _loadCountData() async{
    int temp1 = await CountService.countAdminUser();
    int temp2 = await CountService.countAdminLocation();
    int temp3 = await CountService.countAdminScheduleToday();
    int temp4 = await CountService.countAdminScheduleTodayCompleted();
    int cnt1 = await CountService.countAdminTotalVisitationCurrentMonth();
    int cnt2 = await CountService.countAdminTotalVisitationCurrentMonthCompleted();
    setState(() {
      cntUser = temp1;
      cntLocation = temp2 ;
      cntVisitationToday = temp3;
      cntVisitationTodayCompleted = temp4;
      cntTotalVisit = cnt1;
      cntTotalCompleteVisit = cnt2;
      povScore = (cntTotalCompleteVisit / cntTotalVisit) * 100;
    });
  }
  Future<void> _loadData() async{
    pref = await SharedPreferences.getInstance();
    List<JobListModel> res = await GetAdminService.getListJobToday();
    List<TRVisitationScheduleModel> resComp = await GetAdminService.getListScheduleTodayCompleted();
    // List<TRVisitationScheduleModel> resSche = await GetAdminService.getListSchedule();
    List<MTLocationTypeModel> resType = await GetAdminService.getListLocationType();
    List<MTLocationModel> loc = await GetAdminService.getListLocation();
    List<MTUserModel> user = await GetAdminService.getListUser();
    List<MTVisitationPurpose> purpose = await GetAdminService.getListVisitationPurpose();
    setState(() {
      scheduleData = res  ;
      scheduleCompletedData = resComp;
      // visitedData = resSche;
      locationData = loc;
      locationTypeData = resType;
      userData = user;
      isLoading = false;
      visitationPurpose = purpose;
    });

    List<DropdownItemModel> temp1 = userData.asMap().entries.map((entry) {
      final index = (entry.value.id).toString();
      final name = entry.value.userName;
      return DropdownItemModel(
        id: index,
        label: name ?? '',
      );
    }).toList();

    List<DropdownItemModel> temp2 = locationData.asMap().entries.map((entry) {
      final index = (entry.value.id).toString();
      final name = entry.value.name;
      return DropdownItemModel(
        id: index,
        label: name ?? '',
      );
    }).toList();

    List<DropdownItemModel> temp4 = visitationPurpose.asMap().entries.map((entry) {
      final index = (entry.value.id).toString();
      final name = entry.value.name;
      return DropdownItemModel(
        id: index,
        label: name ?? '',
      );
    }).toList();

    List<DropdownItemModel> temp3 = locationTypeData.asMap().entries.map((entry) {
      final index = (entry.value.id).toString();
      final name = entry.value.name;
      return DropdownItemModel(
        id: index,
        label: name ?? '',
      );
    }).toList();

    setState(() {
      personDropdown = temp1;
      locationDropdown = temp2;
      locationTypeDropdown = temp3;
      visitationPurposeDropdown = temp4;
    });
  }

  @override
  Widget build(BuildContext context) {
    var visitedDataAsync = ref.watch(visitationFullProvider);
    var locationDataAsync = ref.watch(locationProvider);

    final isAnyLoading = visitedDataAsync.isLoading || locationDataAsync.isLoading;
    final hasError = visitedDataAsync.hasError || locationDataAsync.hasError;

    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Dashboard Administrator',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: isLoading ? Center(child: CircularProgressIndicator(),):
              isAnyLoading ? Center(child: CircularProgressIndicator()) :
                  hasError? CustomProgressIndicator.showInformation(context, 'Gagal mengambil admin panel', 'Error') :
                  DefaultTabController(
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
                                  child: _schedule(visitedDataAsync.value ?? []),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(AppSpacing.xs),
                                  child: _location(locationDataAsync.value ?? []),
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
                  )
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
                    number: '${povScore.toStringAsFixed(2)}/100',
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
                child:
                scheduleData.isEmpty ?
                CustomProgressIndicator.showInformation(context, 'Tidak ada jadwal', 'Info') :
                ListView(
                  children: [
                    ...scheduleData.asMap().entries.map((entry){
                      final data = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardBodyResume(
                          id: entry.key,
                          score: 0,
                          hourFrom: ParsingHelper.splitTimePost(data.startDateTime),
                          status: data.scheduleStatus ?? '',
                          name: data.locationName,
                          person: data.fullName,
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
                child: scheduleCompletedData.isEmpty ?
                CustomProgressIndicator.showInformation(context, 'Tidak ada aktifitas terbaru', 'Info') :
                ListView(
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

  Widget _schedule(List<JobListModel> visitedData){
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
        if(visitedData.isEmpty)
          CustomProgressIndicator.showInformation(context, 'Tidak ada jadwal kunjungan', 'Info'),
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

  List<DataCell> _buildScheduleVisitCells(JobListModel data) {
    return [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.locationName ?? ''
              ),
              Text(
                data.locationAddress ?? '',
                style: AppText.caption,
              )
            ],
          ),
        ),
      ),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Text(
          data.fullName ?? '',
        )
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
              title: data.schedulePriority ?? '',
              fontColor: ParsingColor.cekColor(data.schedulePriority ?? '')[0],
              containerColor: ParsingColor.cekColor(data.schedulePriority ?? '')[1]
          )
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: CustomHighlightDashboard(
            title: data.scheduleStatus ?? '',
            fontColor: ParsingColor.cekColor(data.scheduleStatus ?? '')[0],
            containerColor: ParsingColor.cekColor(data.scheduleStatus ?? '')[1]
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
          initialValue: scheduleControllers['MTAssignedUserID']?.text,
          onChanged: (value){
              // selectedAssignValue = value;
            scheduleControllers['MTAssignedUserID']?.text = value!;
            print('PERSON CHECK ${scheduleControllers['MTAssignedUserID']?.text}');
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Location',
          items: locationDropdown,
          initialValue: scheduleControllers['MTLocationID']?.text,
          onChanged: (value){
              // selectedLocationValue = value;
            scheduleControllers['MTLocationID']?.text = value!;
            print('LOCATION CHECK ${scheduleControllers['MTLocationID']?.text}');
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDateTimePicker(
            label: 'Start Date Time',
            firstDate: DateTime.now(),
            controller: scheduleControllers['StartDateTime']!,
            isRequired: true,
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDateTimePicker(
            label: 'End Date Time',
            firstDate: DateTime.now(),
            controller: scheduleControllers['EndDateTime']!,
            isRequired: true,

        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Priority',
          items: DropdownData.priorityData,
          initialValue: scheduleControllers['Priority']?.text,
          onChanged: (value){
            scheduleControllers['Priority']?.text = value!;
            print('priority CHECK ${scheduleControllers['Priority']?.text}');

          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Visitation Purpose',
          items: visitationPurposeDropdown,
          initialValue: scheduleControllers['MTVisitationPurposeID']?.text,
          onChanged: (value){
            scheduleControllers['MTVisitationPurposeID']?.text = value!;
            print('priority CHECK ${scheduleControllers['MTVisitationPurposeID']?.text}');

          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
            label: 'Visit Purpose Description',
            maxLines: 3,
            hint: 'Describe the purpose of this visit',
            keyboardType: TextInputType.multiline,
            controller: scheduleControllers['VisitationDescription']!,
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Create Schedule',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.zero,
            onPressed: () async{
              bool check = await CustomAller().showConfirmDialog(context, 'Create Confirmation!', 'Are you sure you want to add the data?');
              if(check){
                CustomProgressIndicator.showLoadingDialog(context);
                final fields = [
                  'MTAssignedUserID','MTLocationID', 'StartDateTime', 'EndDateTime', 'Priority', 'VisitationDescription',
               'MTVisitationPurposeID'
                ];

                bool isValid = true;
                for (var field in fields) {
                  if (scheduleControllers[field]!.text.isEmpty) {
                    print('FIELD = $field');
                    isValid = false;
                    break;
                  }
                }

                if (!isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all fields.'),
                      backgroundColor: AppColor.error,
                    ),
                  );
                  CustomProgressIndicator.hideLoading();
                  return Navigator.pop(context);
                }
                final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

                // Parsing string ke DateTime
                final DateTime firstDT = formatter.parse(scheduleControllers['StartDateTime']!.text);
                final DateTime secondDT = formatter.parse(scheduleControllers['EndDateTime']!.text);

                final DateTime firstDate = DateTime(firstDT.year, firstDT.month, firstDT.day);
                final DateTime secondDate = DateTime(secondDT.year, secondDT.month, secondDT.day);

                if (secondDate.isBefore(firstDate)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'The end date time cannot be earlier than the start date time.'), backgroundColor: Colors.red,
                    ),
                  );
                  CustomProgressIndicator.hideLoading();
                  return Navigator.pop(context);
                }

                if(secondDate == firstDate){
                  if(secondDT.isBefore(firstDT)){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'The end date time cannot be earlier than the start date time.'), backgroundColor: Colors.red,
                      ),
                    );
                    CustomProgressIndicator.hideLoading();
                    return Navigator.pop(context);
                  }
                }

                scheduleControllers['Status']?.text = 'Scheduled';
                scheduleControllers['CreatedByUserID']?.text = pref.getString('userId').toString();
                scheduleControllers['CreatedDateTime']?.text = DateTime.now().toString();
                Map<String, String?> updateData = {
                  for(var entry in scheduleControllers.entries) entry.key: entry.value.text == '' ? null : entry.value.text,
                };
                // updatedData = ref.read(crewCertificateProvider).information;
                final data = TRVisitationScheduleModel.convertToModel(TRVisitationScheduleModel(), updateData);
                print("CEK UPDATE = ${data.toJson()}");
                bool cek = await AddService.trVisitationSchedule(data.toJson());
                print('HASIL ADD SCHEDULE $cek');
                if(cek){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Successfully add new schedule.'), backgroundColor: AppColor.success,
                    ),
                  );
                  for (var controller in scheduleControllers.values) {
                    controller.clear();
                  }
                  await ref.read(visitationTodayProvider.notifier).reload();
                  await ref.read(visitationFullProvider.notifier).reload();
                  CustomProgressIndicator.hideLoading();
                  return Navigator.pop(context);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'failed add new schedule.'), backgroundColor: AppColor.error,
                    ),
                  );
                  CustomProgressIndicator.hideLoading();
                  return Navigator.pop(context);
                }
              }
            }
        )
      ],
    );
  }

  Widget _location(List<MTLocationModel> listLocationData){
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
          // ListView(
          //   shrinkWrap: true,
          //   children: [
          //     ...locationData.asMap().entries.map((entry){
          //       final data = entry.value;
          //       return Padding(
          //         padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          //         child: CustomCardLocationAdmin(
          //             id : entry.key,
          //             data: data
          //         ),
          //       );
          //     })
          //   ],
          // ),
          if(listLocationData.isEmpty)
            CustomProgressIndicator.showInformation(context, 'Tidak ada lokasi terdaftar', 'Info'),
          Column(
            children: [
              ...listLocationData.asMap().entries.map((entry) {
                final data = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: CustomCardLocationAdmin(
                    id: entry.key,
                    data: data,
                  ),
                );
              }).toList(),
            ],
          ),
          SizedBox(height: AppSpacing.md,)
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
          controller: locationControllers['Name'],
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomDropdownWithLabel(
          label: 'Type',
          items: locationTypeDropdown,
          initialValue: locationControllers['MTLocationTypeID']?.text,
          onChanged: (value){
            locationControllers['MTLocationTypeID']?.text = value!;
            print('LOCATION TYPE CHECK ${locationControllers['MTLocationTypeID']?.text}');
            // setState(() {
            //   selectedTypeLocationValue = value;
            // });
          },
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
          label: 'Address',
          maxLines: 3,
          hint: 'Full address of the location',
          keyboardType: TextInputType.multiline,
          controller: locationControllers['Address'],
        ),
        SizedBox(height: AppSpacing.xs,),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithLabel(
                label: 'Latitude',
                hint: '-6.2088',
                controller: locationControllers['Latitude'],
              ),
            ),
            SizedBox(width: AppSpacing.xs,),
            Expanded(
              child: CustomTextFieldWithLabel(
                label: 'Longitude',
                hint: '-6.2088',
                controller: locationControllers['Longitude'],
              ),
            )
          ],
        ),
        SizedBox(height: AppSpacing.xs,),
        CustomTextFieldWithLabel(
          label: 'Geofence (m)',
          hint: '100',
          controller: locationControllers['GeoFence'],
        ),
        SizedBox(height: AppSpacing.xs,),
        // CustomTextFieldWithLabel(
        //   label: 'Description',
        //   hint: 'Additional details about this location',
        //   maxLines: 3,
        //   keyboardType: TextInputType.multiline,
        //   controller: ,
        // ),
        // SizedBox(height: AppSpacing.xs,),
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Create Location',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.zero,
            onPressed: () async{
              bool check = await CustomAller().showConfirmDialog(context, 'Create Confirmation!', 'Are you sure you want to add the data?');
              if(check){
                final fieldsLoc = [
                  'Name','MTLocationTypeID', 'Address', 'Latitude', 'Longitude', 'GeoFence'
                ];
                bool isValid = true;
                for (var field in fieldsLoc) {
                  if (locationControllers[field]!.text.isEmpty) {
                    print('FIELD = $field');
                    isValid = false;
                    break;
                  }
                }

                if (!isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all fields.'),
                      backgroundColor: AppColor.error,
                    ),
                  );
                  return Navigator.pop(context);
                }

                if(double.tryParse(locationControllers['Latitude']!.text) == null){
                  print("Latitude must be a decimal.");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Latitude must be a decimal.'), backgroundColor: AppColor.error,
                    ),
                  );
                  return Navigator.pop(context);
                }
                if(double.tryParse(locationControllers['Longitude']!.text) == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Longitude must be a decimal  .'), backgroundColor: AppColor.error,
                    ),
                  );
                  return Navigator.pop(context);
                }
                if(int.tryParse(locationControllers['GeoFence']!.text) == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'GeoFence must be a number.'), backgroundColor: AppColor.error,
                    ),
                  );
                  return Navigator.pop(context);
                }

                // locationControllers['IsActive']?.text = 'true';
                locationControllers['CreatedByUserID']?.text = pref.getString('userId').toString();
                locationControllers['CreatedDateTime']?.text = DateTime.now().toString();
                Map<String, String?> updateData = {
                  for(var entry in locationControllers.entries) entry.key: entry.value.text == '' ? null : entry.value.text,
                  'IsActive': '1'
                };
                // updatedData = ref.read(crewCertificateProvider).information;
                final data = MTLocationModel.convertToModel(MTLocationModel(), updateData);
                print("CEK UPDATE = ${data.toJson()}");
                bool cek = await AddService.mtLocation(data.toJson());
                print('HASIL ADD LOCATION $cek');
                if(cek){
                  await ref.read(locationProvider.notifier).reload();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Successfully add new location.'), backgroundColor: AppColor.success,
                    ),
                  );
                  for (var controller in locationControllers.values) {
                    controller.clear();
                  }

                  return Navigator.pop(context);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'failed add new location.'), backgroundColor: AppColor.error,
                    ),
                  );
                  return Navigator.pop(context);
                }
              }
            }
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
        if(userData.isEmpty)
          CustomProgressIndicator.showInformation(context, 'Tidak ada pengguna', 'Info'),
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
              title: (data.isActive == true  ? 'Aktif' : 'Non Active').toString(),
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
