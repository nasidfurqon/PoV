import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/core/utils/config.dart';
import 'package:pov2/core/widget/custom_modal_dialog.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_pdf_viewer.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/data/models/documentation_model.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class DocumentationDetailPage extends StatefulWidget {
  final dynamic id;
  final String type;
  const DocumentationDetailPage({super.key, required this.id, required this.type});

  @override
  State<DocumentationDetailPage> createState() => _DocumentationDetailPageState();
}

class _DocumentationDetailPageState extends State<DocumentationDetailPage> {
  DocumentationModel? docData;
  List<dynamic>? attachmentData;
  String? employeeId;
  late SharedPreferences pref;

  @override
  void initState(){
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async{
    pref = await SharedPreferences.getInstance();
    DocumentationModel? temp = await GetService.getDocumentationByScheduleID(widget.id, widget.type);
    setState(() {
      docData = temp;
      attachmentData = docData?.attachment;
      employeeId = pref.getString('employeeId');
    });
    print('CHECK DOCUMENTATION DATA = $docData');
  }

  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Documentation Detail'
        ),
        body: docData == null ?
            Center(child: CircularProgressIndicator()) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  AppSpacing.global),
          child: Column(
            children: [
              if(widget.type == 'Photo')
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4
                  ),
                  shrinkWrap: true,
                  itemCount: attachmentData?.length,
                  itemBuilder: (context, index){
                    final photo = attachmentData?[index];
                    print("CEK PHOTO = $photo");
                    final imageUrl = "${AppConfig.serverAddress}/uploads/kunjungan/${employeeId}/${photo}";
                    print("IMAGE URL $imageUrl");
                    return GestureDetector(
                      onTap: (){
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => CustomNormalScaffold(
                        //             context: context,
                        //             title: Text('data'),
                        //             body: Image.network(imageUrl, fit: BoxFit.cover,)
                        //         )
                        //     )
                        // );
                        CustomModelDialog.show(
                            context,
                            Text('${photo} Review'),
                            Image.network(imageUrl, fit: BoxFit.cover)
                        );
                      },
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  }
              ),
              if(widget.type == 'Document')
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: attachmentData?.length,
                  itemBuilder: (context, index){
                    final doc = attachmentData?[index];
                    final docUrl = "${AppConfig.serverAddress}/uploads/kunjungan/${employeeId}/${doc}";
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.description, color: AppColor.primary),
                        title: Text('$doc'),
                        onTap: () async{
                          CustomModelDialog.show(
                              context,
                              Text('${doc} Review'),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.8,
                                width: double.infinity,
                                child: CustomPdfViewerPage(url: docUrl, fileName: doc, isFull: false,),
                              ),
                            isScrollable: false
                          );
                        },
                      ),
                    );
                  }
              )
            ],
          ),
        )
    );
  }
}
