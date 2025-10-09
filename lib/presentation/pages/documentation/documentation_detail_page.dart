import 'package:flutter/material.dart';
import 'package:pov2/core/utils/config.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/data/models/documentation_model.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomNormalScaffold(
        context: context,
        title: Text(
          'Documentation Detail'
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4
            ),
            itemCount: attachmentData?.length,
            itemBuilder: (context, index){
              final photo = attachmentData?[index];
              final imageUrl = "${AppConfig.serverAddress}/uploads/kunjungan/${employeeId}/${photo}";
              print("IMAGE URL $imageUrl");
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CustomNormalScaffold(
                              context: context,
                              title: Text('data'),
                              body: Image.network(imageUrl, fit: BoxFit.cover,)
                          )
                      )
                  );
                },
                child: Image.network(imageUrl, fit: BoxFit.cover,),
              );
            }
        )
    );
  }
}
