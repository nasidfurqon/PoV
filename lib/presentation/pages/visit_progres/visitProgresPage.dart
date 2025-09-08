import 'package:flutter/material.dart';

class VisitProgressPage extends StatefulWidget {
  final dynamic  id;
  const VisitProgressPage({super.key, required this.id});

  @override
  State<VisitProgressPage> createState() => _VisitProgressPageState();
}

class _VisitProgressPageState extends State<VisitProgressPage> {
  @override
  Widget build(BuildContext context) {
    print('ID VISIT = ${widget.id}');
    return SizedBox();
  }
}
