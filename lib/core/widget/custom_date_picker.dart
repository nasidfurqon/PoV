import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_spacing.dart';

import '../../config/theme/app_text.dart';

class CustomDatePicker extends StatefulWidget{
  final String label;
  final bool? isRequired;
  final bool? isEnabled;
  final TextStyle? textStyle;
  final TextEditingController controller;

  const CustomDatePicker({
    super.key, required this.label, this.textStyle, this.isEnabled, required this.controller, this.isRequired
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePicker();
}

class _CustomDatePicker extends State<CustomDatePicker>{
  Future<void> _selectDate(BuildContext context) async{
    DateTime initialDate = DateTime.now();
    if(widget.controller!.text.isNotEmpty){
      try{
        initialDate = DateTime.parse(widget.controller!.text);
      }
      catch(e){
        initialDate = DateTime.now();
      }
    }
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate:  initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000)
    );
    if(pickedDate != null){
      setState(() {
        widget.controller!.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired == true ?
        Row(
          children: [
            Text(
              widget.label,
              style: widget.textStyle ?? AppText.body,
            ),
            const Text(
              '*',
              style: const TextStyle(
                color: AppColor.error,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ):
        Text(
          widget.label,
          style: widget.textStyle ?? AppText.body,
        ) ,
        const SizedBox(height: AppSpacing.xxs),
        TextField(
            enabled: widget.isEnabled != false,
            // enabled: true,
            controller: widget.controller,
            readOnly: true,
            style: AppText.body,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.edit_calendar, size: 18,),
                hintStyle: AppText.caption,
                contentPadding: EdgeInsets.all(AppSpacing.sm),
                filled: true,
                fillColor: AppColor.background,
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
        )
      ],
    );
  }}