import 'package:flutter/material.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/theme/app_text.dart';

class CustomTimeField extends StatefulWidget {
  final String label;
  final TextStyle? textStyle;
  final TextEditingController controller;

  const CustomTimeField({
    Key? key,
    required this.label,
    this.textStyle,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  String period = "AM";

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      final selectedPeriod = picked.period == DayPeriod.am ? "AM" : "PM";

      setState(() {
        widget.controller.text = "$hour:$minute $selectedPeriod";
        period = selectedPeriod;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: widget.textStyle ?? AppText.body,
        ),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: _pickTime,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(AppSpacing.sm),
            suffixIcon: IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: _pickTime,
            ),
            border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide(color: AppColor.primary, width: 1.5)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide(color: AppColor.border),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide(color: AppColor.textSecondary)
              )
          ),
        ),
      ],
    );
  }
}
