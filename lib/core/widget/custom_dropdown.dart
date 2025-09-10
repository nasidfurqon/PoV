import 'package:flutter/material.dart';
import 'package:pov2/config/theme/app_spacing.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/data/models/dropdown_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropdownItemModel> items;
  final String initialValue;
  final void Function(String?) onChanged;
  final void Function(String?)? onSaved;
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.onSaved,
    this.hint,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedId;

  @override
  void initState(){
    super.initState();
    selectedId = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedId,
      decoration: InputDecoration(
        isDense: true ,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide(color: AppColor.border)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: AppColor.border),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      ),
      hint: Text(widget.hint ?? "Pilih item"),
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item.id,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.label),
              if (selectedId == item.id)
                const Icon(Icons.check_circle, color: AppColor.success, size: 20),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedId = value;
        });
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      onSaved: widget.onSaved,
      selectedItemBuilder: (context) {
        return widget.items.map((item) {
          return Text(
            item.label,
            style: AppText.highlightPrimary,
          );
        }).toList();
      },

    );
  }
}


class CustomDropdownWithLabel extends StatefulWidget {
  final String label;
  final TextStyle? textStyle;
  final List<DropdownItemModel> items;
  final String initialValue;
  final void Function(String?) onChanged;
  final void Function(String?)? onSaved;
  final String? hint;

  const CustomDropdownWithLabel({
    super.key,
    required this.label,
    this.textStyle,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.onSaved,
    this.hint,
  });

  @override
  State<CustomDropdownWithLabel> createState() => _CustomDropdownWithLabelState();
}

class _CustomDropdownWithLabelState extends State<CustomDropdownWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: widget.textStyle ?? AppText.body,
        ),
        SizedBox(height: AppSpacing.xs),
        CustomDropdown(items: widget.items, onSaved: widget.onSaved, hint: widget.hint ,initialValue: widget.initialValue, onChanged: widget.onChanged)
      ],
    );
  }
}
