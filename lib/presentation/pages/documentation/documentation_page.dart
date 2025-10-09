import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/models/documentation_model.dart';
import 'package:pov2/data/models/trVisitationScheduleEvidence_model.dart';
import 'package:pov2/data/services/count_service.dart';
import 'package:pov2/data/services/document_data.dart';
import 'package:pov2/data/services/get_admin_service.dart';
import 'package:pov2/presentation/widgets/custom_card_document.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  Map<String, List<TRVisitationScheduleEvidenceModel>> documentData = {};
  List<DocumentationModel> documentationData = [];
  int photoCount = 0;
  int documentCount = 0;
  int videoCount = 0;

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  void _loadData() async{
    var temp = await CountService.countAdminTotalDocument('Foto');
    var temp2 = await CountService.countAdminTotalDocument('Dokumen');
    var temp3 = await CountService.countAdminTotalDocument('Video');
    var temp4 = await GetAdminService.getEvidenceByCategoryAndSchedule();
    var temp5 = await GetAdminService.getListDocumentation();
    setState(() {
      photoCount = temp;
      documentCount = temp2;
      videoCount = temp3;
      documentData = temp4;
      documentationData = temp5;
    });

    print('CEK DOCUMENT DATA IN DOCUMENTATION PAGE = ${documentationData}');
  }

  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Documentation',
          style: AppText.heading2,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.global),
          child: ListView(
            children: [
              CustomHeaderCard(number: photoCount.toString(), status: 'Foto'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: documentCount.toString(), status: 'Dokumen'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: videoCount.toString(), status: 'Video'),
              SizedBox(height: AppSpacing.sm,),
              // ...documentData.entries.map((entry){
              //   final key = entry.key;
              //   final data = entry.value;
              //   return Column(
              //     children: [
                    ...documentationData.asMap().entries.map((e) {
                      final index = e.key;
                      final dataMap = e.value;
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CustomCardDocument(id: index, data: dataMap),
                      );
                    }),
                //   ],
                // );
                // return Padding(
                //   padding: EdgeInsets.only(bottom: AppSpacing.xs),
                //   child: CustomCardDocument(id:index, data: data),
                // );
              // })
            ],
          ),
        )
    );
  }
}
