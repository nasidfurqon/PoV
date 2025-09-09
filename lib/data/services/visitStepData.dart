import 'package:flutter/material.dart';

class VisitStepData{
  final List<Map<String, dynamic>> stepData = [
    {
      'title': 'Location Verification',
      'description': 'Verify you\'re at the correct location',
      'icon': Icons.location_on,
      'currentLocation': '-6.208700, 106.845700',
      'targetLocation': '-6.2088, 106.8456',
      'accuracy': '±5m',
      'geofence': '50m radius',
      'isInGeofence': true,
    },
    {
      'title': 'Selfie Documentation',
      'description': 'Take a selfie to verify your presence at the location ',
      'icon': Icons.camera_alt,
    },
    {
      'title': 'Visit Completion',
      'description': 'Complete your visit',
      'icon': Icons.check_circle,
    },
  ];
}