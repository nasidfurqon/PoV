import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/core/widget/custom_card.dart';
import 'package:pov2/data/services/visitData.dart';
import 'package:pov2/data/services/visitStepData.dart';
import 'package:pov2/presentation/pages/visit_progres/visitCompletion.dart';

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

  @override
  Widget build(BuildContext context) {
    print('ID VISIT = ${widget.id}, data = ${visitData}');
    final currentStepData = stepData[currentStep - 1];
    final progressPercentage = ((currentStep / totalSteps) * 100).round();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              visitData['place'],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              visitData['street'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCard(
                color: Colors.white,
                padding: EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Visit Progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '$progressPercentage% Complete',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Step $currentStep of $totalSteps',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _progressAnimation.value,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                            minHeight: 8,
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ),
            // Progress Card
            SizedBox(height: AppSpacing.lg),
            if(currentStep == 3)
              VisitCompletionPage(placeName: visitData['place'], placeAddress: visitData['street'])
            else
              CustomCard(
                  color: Colors.white,
                  padding: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                currentStepData['icon'],
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentStepData['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentStepData['description'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Step-specific content
                        _buildStepContent(currentStepData),
                        const SizedBox(height: 24),
                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _nextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              currentStepData['buttonText'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
          ],
        ),
      ),
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
        _buildInfoRow('Current Location', data['currentLocation'], Icons.my_location),
        const SizedBox(height: 12),
        _buildInfoRow('Accuracy', data['accuracy'], Icons.gps_fixed),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        _buildInfoRow('Target Location', data['targetLocation'], Icons.location_on),
        const SizedBox(height: 12),
        _buildInfoRow('Geofence', data['geofence'], Icons.radio_button_unchecked),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Within geofence area',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
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
      ],
    );
  }

  Widget _buildPhotoDocumentationContent(Map<String, dynamic> data) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
                SizedBox(height: 8),
                Text('Photos will appear here', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionContent(Map<String, dynamic> data) {
    return Column(
      children: [
        const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
        const SizedBox(height: 16),
        const Text(
          'Ready to Complete Visit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
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

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        // Icon(icon, size: 16, color: Colors.grey[600]),
        // const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
