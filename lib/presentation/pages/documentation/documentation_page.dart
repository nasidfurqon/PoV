import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/services/document_data.dart';
import 'package:pov2/presentation/widgets/custom_card_document.dart';
import 'package:pov2/presentation/widgets/custom_header_card.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  final List<Map<String, dynamic>> documentData = DocumentData().data;
  late int fotoCount = documentData
      .where((item) => item['type'] == 'JPG')
      .length;

  late int documentCount = documentData
      .where((item) => item['type'] == 'PDF')
      .length;

  late int videoCount = documentData
      .where((item) => item['type'] == 'MP4')
      .length;
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
              CustomHeaderCard(number: '1', status: 'Foto'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: '2', status: 'Dokumen'),
              SizedBox(height: AppSpacing.sm,),
              CustomHeaderCard(number: '1', status: 'Video'),
              SizedBox(height: AppSpacing.sm,),
              ...documentData.asMap().entries.map((entry){
                final index = entry.key;
                final data = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.xs),
                  child: CustomCardDocument(id:index, data: data),
                );
              })
            ],
          ),
        )
    );
  }
}
