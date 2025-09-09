import 'package:flutter/material.dart';

class VisitStepData{
  List<Map<String, dynamic>> stepData = [
    {
      'title': 'Location Verification',
      'description': 'Verify you\'re at the correct location',
      'icon': Icons.location_on,
      'currentLocation': {
        'lat': '-',
        'long': '-'
      },
      'targetLocation': {
        'lat': '-6.208700',
        'long': '106.845700'
      },
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