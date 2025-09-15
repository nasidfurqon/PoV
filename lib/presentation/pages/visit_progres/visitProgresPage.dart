import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/location.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_photo_preview.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';
import 'package:pov2/data/services/visit_data.dart';
import 'package:pov2/data/services/visitStep_data.dart';
import 'package:pov2/presentation/pages/visit_progres/visitCompletion.dart';
import 'package:go_router/go_router.dart';
import 'package:pov2/presentation/widgets/custom_header_visit.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/camera_helper.dart';
class VisitProgressPage extends StatefulWidget {
  final dynamic id;
  const VisitProgressPage({super.key, required this.id});

  @override
  State<VisitProgressPage> createState() => _VisitProgressPageState();
}

class _VisitProgressPageState extends State<VisitProgressPage> with TickerProviderStateMixin {
  late Map<String, dynamic> visitData = VisitData().taskData[int.tryParse(widget.id )!];
  int currentStep = 1;
  final int totalSteps = 3;
  final List<Map<String, dynamic>> stepData = VisitStepData().stepData;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;
  File? _capturedPhotos;
  Position? positioned = null;
  bool isValid = false;

  @override
  void initState(){
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0,
      end: currentStep / totalSteps,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));
    _progressAnimationController.forward();
  }

  @override
  void dispose(){
    _progressAnimationController.dispose();
    super.dispose();
  }

  void _nextStep(){
    if(currentStep < totalSteps){
      setState(() {
        currentStep++;
      });
      _progressAnimation = Tween<double>(
        begin:_progressAnimation.value,
        end:currentStep/totalSteps,
      ).animate(CurvedAnimation(
          parent: _progressAnimationController,
          curve: Curves.easeInOut
      ));
      _progressAnimationController.reset();
      _progressAnimationController.forward();
    }
  }

  Future<void> _takePhoto() async{
    final file = await CameraHelper.takePhoto();
    if(file != null){
      setState(() {
        _capturedPhotos = file;

      });
    }
  }

  void _checkLocation() async{
    CustomProgressIndicator.showLoadingDialog(context);
    Position pos = await LocationHelper.getCurrentLocation();
    CustomProgressIndicator.hideLoading();
    setState(() {
      positioned = pos;
      print('GET LOCATION, LAT ${positioned?.latitude}, LONG= ${positioned?.longitude} ');
      stepData[0]['currentLocation']['lat'] = (positioned?.latitude).toString();
      stepData[0]['currentLocation']['long'] = (positioned?.longitude).toString();
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Location is Valid!',
            style: AppText.heading4Tertiary,
          ),
          backgroundColor: AppColor.success,
          duration: Duration(milliseconds: 800),
        )
    );
  }

  void _checkPhoto(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Photo is Valid!',
            style: AppText.heading4Tertiary,
          ),
          backgroundColor: AppColor.success,
          duration: Duration(milliseconds: 800),
        )
    );
    setState(() {
      isValid = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentStepData = stepData[currentStep - 1];
    final progressPercentage = ((currentStep / totalSteps) * 100).round();

    return CustomNormalScaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(progressPercentage),
              // Progress Card
              SizedBox(height: AppSpacing.lg),
              if(currentStep == 3)
                VisitCompletionPage(id: widget.id)
              else
                _body(currentStepData)
            ],
          ),
        ),
        context: context,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                visitData['place'],
                style: AppText.heading3
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
                visitData['street'],
                style: AppText.caption
            ),
          ],
        ),
    );
  }


  Widget _header(dynamic progressPercentage){
    return CustomCard(
      color: Colors.white,
      padding: EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.global),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Visit Progress',
                  style: AppText.heading3
                ),
                Text(
                  '$progressPercentage% Complete',
                  style: AppText.heading4Secondary
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Step $currentStep of $totalSteps',
                  style: AppText.bodySecondary
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  child: LinearProgressIndicator(
                    value: _progressAnimation.value,
                    backgroundColor: AppColor.background,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    minHeight: 8,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _body(dynamic currentStepData){
    return CustomCard(
        color: Colors.white,
        padding: EdgeInsets.all(2),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.global),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderVisit(icon: currentStepData['icon'], title: currentStepData['title'], description: currentStepData['description']),
              const SizedBox(height: AppSpacing.md),
              // Step-specific content
              _buildStepContent(currentStepData),
            ],
          ),
        )
    );
  }
  Widget _buildStepContent(Map<String, dynamic> stepData) {
    switch (currentStep) {
      case 1:
        return _buildLocationVerificationContent(stepData);
      case 2:
        return _buildPhotoDocumentationContent(stepData);
      case 3:
        return _buildCompletionContent(stepData);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLocationVerificationContent(Map<String, dynamic> data) {
    return Column(
      children: [
        _buildInfoRow('Current Location', '${data['currentLocation']['lat']},${data['currentLocation']['long']} '),
        const SizedBox(height: AppSpacing.sm),
        _buildInfoRow('Accuracy', data['accuracy']),
        const SizedBox(height: AppSpacing.md),
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        _buildInfoRow('Target Location', '${data['targetLocation']['lat']},${data['targetLocation']['long']} '),
        const SizedBox(height: AppSpacing.sm),
        _buildInfoRow('Geofence', data['geofence']),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            const Icon(Icons.check_circle, color: AppColor.success, size: AppSpacing.lg),
            const SizedBox(width: 8),
            const Text(
              'Within geofence area',
              style: TextStyle(
                color: AppColor.success,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DEMO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),
        // Action Button
        if(positioned == null)
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Check In',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
            onPressed: (){
              _checkLocation();
            }
        ),
        if(positioned != null)
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Next',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
            onPressed: (){
              _nextStep();
            }
        ),
      ],
    );
  }

  Widget _buildPhotoDocumentationContent(Map<String, dynamic> data) {
    return Column(
      children: [

        if(_capturedPhotos == null)
          CustomCard(
            padding: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate, size: AppSpacing.xl, color: Colors.grey),
                    SizedBox(height: AppSpacing.sm),
                    Text('Photos will appear here', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),
        CustomPhotoPreview(photo: _capturedPhotos),
        const SizedBox(height: AppSpacing.md),
        // Action Button
        if(_capturedPhotos == null)
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Take Selfie',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
            onPressed: (){
              _takePhoto();
            }
        ),
        if(_capturedPhotos != null)
        Row(
          children: [
            Expanded(
              child: CustomButtonFull(
                  textStyle: AppText.heading4Tertiary,
                  title: 'Check',
                  backgroundColor: AppColor.primary,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  onPressed: (){
                    _checkPhoto();
                  }
              ),
            ),
            SizedBox(width: AppSpacing.md,),
            Expanded(
              child: CustomButtonFull(
                  textStyle: AppText.heading4Tertiary,
                  isActive: isValid,
                  title: 'Next Step',
                  backgroundColor: AppColor.primary,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  onPressed: (){
                    _nextStep();
                  }
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildCompletionContent(Map<String, dynamic> data) {
    return Column(
      children: [
        const Icon(Icons.check_circle_outline, size: 64, color: AppColor.success),
        const SizedBox(height: 16),
        const Text(
          'Ready to Complete Visit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.success,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'All previous steps have been completed successfully.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: AppText.heading5Secondary
        ),
        const Spacer(),
        Text(
          value,
          style:  AppText.heading5
        ),
      ],
    );
  }
}
