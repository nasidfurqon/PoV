import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/utils/camera_helper.dart';
import 'package:pov2/core/utils/file_helper.dart';
import 'package:pov2/core/utils/format_date.dart';
import 'package:pov2/core/widget/custom_button.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/core/widget/custom_dropdown.dart';
import 'package:pov2/core/widget/custom_file_preview.dart';
import 'package:pov2/core/widget/custom_photo_preview.dart';
import 'package:pov2/core/widget/custom_textfield.dart';
import 'package:pov2/data/services/dropdown_data.dart';
import 'package:pov2/presentation/widgets/custom_highlight_dashboard.dart';
import 'package:pov2/presentation/widgets/custom_photo_dialog.dart';
import 'package:pov2/presentation/widgets/custom_row_icon.dart';

import '../../../core/widget/custom_progress_indicator.dart';
import '../../../data/services/visit_data.dart';
import '../../widgets/custom_header_visit.dart';
class VisitCompletionPage extends StatefulWidget {
  final dynamic id;


  const VisitCompletionPage({
    super.key,
    required this.id,
  });

  @override
  State<VisitCompletionPage> createState() => _VisitCompletionPageState();
}

class _VisitCompletionPageState extends State<VisitCompletionPage> {
  late Map<String, dynamic> visitData = VisitData().taskData[int.tryParse(widget.id )!];
  final TextEditingController _notesController = TextEditingController();
  File? _capturedPhotos;
  PlatformFile? _uploadedDocuments;
  String? imageTimeUploaded;
  String? documentTimeUploaded;
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;

  final List<Map<String, dynamic>> photoEvidence = [
    {
      'type': 'evidence',
      'status': 'Verified',
      'timestamp': '2024-01-15 09:30',
      'location': 'Verified',
    },
    {
      'type': 'before',
      'status': 'Verified',
      'timestamp': '2024-01-15 09:31',
      'location': 'Verified',
    },
    {
      'type': 'completion',
      'status': 'Verified',
      'timestamp': '2024-01-15 09:32',
      'location': 'Verified',
    },
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async{
    CustomProgressIndicator.showUploadingDialog(context);
    final file = await CameraHelper.takePhoto();
    if(file != null){
      setState(() {
        _capturedPhotos = file;
        imageTimeUploaded = FormatDate.formatedDateTime(DateTime.now());
      });
    }
    CustomProgressIndicator.hideLoading();
  }

  Future<void> _discardPhoto() async{
    setState(() {
      _capturedPhotos = null;
      imageTimeUploaded = FormatDate.formatedDateTime(DateTime.now());
    });
  }

  Future<void> _uploadPhoto() async{
    CustomProgressIndicator.showUploadingDialog(context);
    final file = await FileHelper.pickPhoto();
    if(file != null){
      setState(() {
        _capturedPhotos = file;
        imageTimeUploaded = FormatDate.formatedDateTime(DateTime.now());
      });
    }
    CustomProgressIndicator.hideLoading();
  }

  Future<void> _uploadFile() async{
    CustomProgressIndicator.showUploadingDialog(context);
    final file = await FileHelper.pickDocument();
    if(file != null){
      setState(() {
        _uploadedDocuments = file;
        documentTimeUploaded = FormatDate.formatedDateTime(DateTime.now());
      });
    }
    CustomProgressIndicator.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Photo Evidence Section
        _buildPhotoEvidenceCard(),

        const SizedBox(height: AppSpacing.md),

        // Document Upload Section
        _buildDocumentUploadCard(),

        const SizedBox(height:  AppSpacing.md),

        // Photo Evidence Gallery
        _buildPhotoEvidenceGallery(),

        const SizedBox(height:  AppSpacing.md),

        // Visit Notes Section
        _buildVisitNotesCard(),

        const SizedBox(height: AppSpacing.lg),

        // Complete Visit Button
        CustomButtonFull(
            textStyle: AppText.heading4Tertiary,
            title: 'Complete Visit',
            backgroundColor: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
            onPressed: (){
              _showFinalConfirmationDialog();
            }
        ),

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildPhotoEvidenceCard() {
    return CustomCard(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.global),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader2Visit(icon: Icons.camera_alt_outlined, title: 'Photo Evidence', description: 'Capture photos with automatic watermarking and location verification'),
            const SizedBox(height: AppSpacing.md),
            CustomPhotoPreview(photo: _capturedPhotos),
            if(_capturedPhotos == null)
            Row(
              children: [
                Expanded(
                  child:
                      CustomButton(
                          icon: Icons.camera,
                          iconColor: AppColor.textTertiary,
                          textStyle: AppText.heading5Tertiary,
                          title: 'Take Photo',
                          backgroundColor: AppColor.primary,
                          padding: EdgeInsets.all(AppSpacing.xs),
                          onPressed: (){
                            _takePhoto();
                          }
                      )
                ),
                const SizedBox(width: 12),
                Expanded(
                  child:
                  CustomButton(
                      icon: Icons.upload,
                      iconColor: AppColor.textPrimary,
                      textStyle: AppText.heading5,
                      title: 'Upload Photo',
                      backgroundColor: AppColor.background,
                      padding: EdgeInsets.all(AppSpacing.xs),
                      onPressed: (){
                        _uploadPhoto();
                      }
                  )
                ),
              ],
            ),
            if(_capturedPhotos != null)
              Column(
                children: [
                  SizedBox(height: AppSpacing.sm),
                  CustomDropdownWithLabel(
                    label: 'Photo Type',
                    textStyle: AppText.heading5,
                    items: DropdownData.photoType,
                    initialValue: '1' ?? '',
                    onChanged: (value){
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  SizedBox(height: AppSpacing.sm),
                  CustomTextFieldWithLabel(
                      textStyle: AppText.heading5,
                      label: 'Description',
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      hint: 'Describe what this photo shows...'
                  ),
                  SizedBox(height: AppSpacing.sm),
                  CustomCard(
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Text(
                              'Watermark Information',
                              style: AppText.heading4,
                            ),
                            SizedBox(height: AppSpacing.sm),
                            CustomRowIcon(icon:  Icons.location_on_outlined,color:  AppColor.textSecondary,title:  visitData['place'], textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.xs),
                            CustomRowIcon(icon:  Icons.access_time_outlined, color:  AppColor.textSecondary, title:  imageTimeUploaded!,textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.sm),
                            CustomRowIcon(icon:  Icons.person, color:  AppColor.textSecondary, title:  '', textStyle:  AppText.heading6Secondary),
                            SizedBox(height: AppSpacing.xs),
                            CustomRowIcon(icon:  Icons.location_on_outlined, color:  AppColor.textSecondary,title:  'GPS Verified',textStyle:  AppText.heading6Secondary),
                          ],
                        ),
                      ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomButton(
                            textStyle: AppText.heading4Tertiary,
                            title: 'Save Photo',
                            backgroundColor: AppColor.primary,
                            padding: EdgeInsets.all(AppSpacing.xs),
                            onPressed: (){}
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                            textStyle: AppText.heading4,
                            title: 'Discard',
                            backgroundColor: AppColor.background,
                            padding: EdgeInsets.all(AppSpacing.xs),
                            onPressed: (){
                              _discardPhoto();
                            }
                        ),
                      )
                    ],
                  )
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadCard() {
    return CustomCard(
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.global),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader2Visit(icon: Icons.description_outlined, title: 'Document Upload', description: 'Upload supporting documents like reports, forms, or certificates'),
            const SizedBox(height: AppSpacing.md),
            CustomFilePreview(file : _uploadedDocuments),
            Center(
              child: Column(
                children: [
                  CustomButton(
                      icon: Icons.upload_file,
                      textStyle: AppText.heading5,
                      title: 'Upload Document',
                      iconColor: AppColor.textPrimary,
                      backgroundColor: AppColor.background,
                      padding: EdgeInsets.all(AppSpacing.xs),
                      onPressed: (){
                        _uploadFile();
                      }
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Supported formats: PDF, Word, Excel, Text files, Images (Max 10MB)',
                    style: AppText.highlight,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoEvidenceGallery() {
    return CustomCard(
      padding: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.global),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader2Visit(icon: Icons.photo_library_outlined, title: 'Photo Evidence (3)', description: 'Watermarked photos with location and timestamp verification'),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photoEvidence.length,
                itemBuilder: (context, index) {
                  final photo = photoEvidence[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: _buildPhotoItem(photo, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoItem(Map<String, dynamic> photo, int index) {
    Color tagColor;
    Color bgColor;
    String tagText;

    switch (photo['type']) {
      case 'evidence':
        tagColor = AppColor.accentMedium;
        bgColor = AppColor.onAccentMedium;
        tagText = 'evidence';
        break;
      case 'before':
        tagColor = AppColor.accentHigh;
        bgColor = AppColor.onAccentHigh;
        tagText = 'before';
        break;
      case 'completion':
        tagColor = AppColor.accentCompletion;
        bgColor = AppColor.onAccentCompletion;
        tagText = 'completion';
        break;
      default:
        tagColor = Colors.grey;
        bgColor = Colors.black;
        tagText = 'photo';
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            CustomPhotoDialog.show(
                context,
                "assets/patra_logo.png",
                tagText,
                "Condition before maintenance work",
                "9/10/2025, 6:14:33 PM",
                "-6.208800, 106.845600",
            );
          },
          child: Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.xs),
              border: Border.all(color: AppColor.background),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: AppColor.primaryTransparent,
                child: const Icon(
                  Icons.image,
                  size: 40,
                  color: AppColor.primary,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child:
            CustomHighlightDashboard(
                title: tagText,
                customFontStyle: true,
                fontWeight: FontWeight.bold,
                fontSize: 9,
                fontColor: tagColor,
                containerColor: bgColor
            )
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: CustomHighlightDashboard(
              title: 'Verified',
              customFontStyle: true,
              fontWeight: FontWeight.bold,
              fontSize: 9,
              fontColor: Colors.white,
              containerColor: AppColor.success
          )
        ),
      ],
    );
  }

  Widget _buildVisitNotesCard() {
    return CustomCard(
      padding: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.global),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader2Visit(icon: Icons.check_circle_outline, title: 'Visit Notes', description: 'Add notes about your visit'),

            const SizedBox(height: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visit Notes',
                  style: AppText.heading5,
                ),
                SizedBox(height: AppSpacing.xs),
                CustomTextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    hint: 'Describe what you observed, any issued found, or actions taken..'
                ),

                SizedBox(height: AppSpacing.sm,),
                Text(
                  'Visit Summary',
                  style: AppText.heading5,
                ),
                SizedBox(height: AppSpacing.xs),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRowIcon(icon: Icons.check_circle_outline, color: AppColor.success,title: 'Location Verified', textStyle:   AppText.heading6,),
                        CustomRowIcon(icon: Icons.check_circle_outline,color:  AppColor.success,title:  'Selfie Verified',textStyle:   AppText.heading6,),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    CustomRowIcon(icon:  Icons.camera_alt_outlined, color:  AppColor.accentMedium,title:  '0 Photos taken',textStyle:   AppText.heading6,),
                  ],
                ),

                SizedBox(height: AppSpacing.sm,),
                CustomHighlightDashboard(
                    title: 'Estimated PoV Score: 80/100',
                    fontColor: AppColor.textPrimary,
                    containerColor: AppColor.background
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showFinalConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.red, size: 32),
            SizedBox(width: 12),
            Text('Complete Visit?'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to complete this visit?'),
            SizedBox(height: 8),
            Text(
              'This action cannot be undone once submitted.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Complete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            SizedBox(height: 16),
            Text('Visit Completed Successfully!'),
          ],
        ),
        content: const Text(
          'Your visit has been completed and all data has been saved.',
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Back to Dashboard', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}