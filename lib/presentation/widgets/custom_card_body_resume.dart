import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/parsing_status_color.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/get_service.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';

class CustomCardBodyResume extends StatelessWidget {
  final dynamic id;
  final dynamic name;
  final dynamic person;
  final String hourFrom;
  final String? actEndDateTime;
  final bool? isNewActivity;
  final double score;
  final String status;
  const CustomCardBodyResume({super.key, this.isNewActivity = false, required this.score, required this.id, required this.name, required this.person, required this.hourFrom, this.actEndDateTime, required this.status});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name is Future<String?> ?
                  FutureBuilder<String?>(
                    future: name as Future<String?>,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("...");
                      } else if (snapshot.hasError) {
                        return const Text('');
                      } else {
                        return Text(
                          snapshot.data!,
                          style: AppText.heading5,
                        );
                      }
                    },) :
                  Text(
                    name,
                    style: AppText.heading5,
                  ),
                  if(isNewActivity == false)
                    person is Future<String?> ?
                    FutureBuilder<String?>(
                      future: person as Future<String?>,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("...");
                        } else if (snapshot.hasError) {
                          return const Text('');
                        } else {
                          return Text(
                            '${snapshot.data!}  \u2022 ${hourFrom}',
                            style: AppText.caption
                          );
                        }
                      },) :
                    Text(
                    '${person} \u2022 ${hourFrom}',
                    style: AppText.caption,
                  ),
                  if(isNewActivity == true)
                    person is Future<String?> ?
                    FutureBuilder<String?>(
                      future: person as Future<String?>,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("...");
                        } else if (snapshot.hasError) {
                          return const Text('');
                        } else {
                          return Text(
                            '${snapshot.data} \u2022 ${actEndDateTime}',
                            style: AppText.caption,
                          );
                        }
                      },) :
                    Text(
                        '${person} \u2022 ${actEndDateTime}',
                      style: AppText.caption,
                    )
                ],
              ),
              SizedBox(width: AppSpacing.xs,),
              Column(
                children: [
                  if(isNewActivity == true)
                    CustomHighlightDashboard(
                        title: '${score}/100',
                        fontColor: ParsingColor.cekColor('score')[0],
                        containerColor:  ParsingColor.cekColor('score')[1]
                    ),
                  if(isNewActivity == true)
                    SizedBox(height: AppSpacing.xs,),
                  CustomHighlightDashboard(
                      title: status,
                      fontColor: ParsingColor.cekColor(status)[0],
                      containerColor:  ParsingColor.cekColor(status)[1]
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
