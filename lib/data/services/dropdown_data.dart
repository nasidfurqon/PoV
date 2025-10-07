import '../models/dropdown_model.dart';

class DropdownData{
  static List<DropdownItemModel> photoType = [
    DropdownItemModel(id: "General Evidence", label: "General Evidence"),
    DropdownItemModel(id: "Before State", label: "Before State"),
    DropdownItemModel(id: "After State", label: "After State"),
    DropdownItemModel(id: "Issue/Problem", label: "Issue/Problem"),
    DropdownItemModel(id: "Task Completion", label: "Task Completion"),
  ];

  static List<DropdownItemModel> priorityData = [
    DropdownItemModel(id: "Low", label: "Low"),
    DropdownItemModel(id: "Normal", label: "Normal"),
    DropdownItemModel(id: "High", label: "High"),
    DropdownItemModel(id: "Urgent", label: "Urgent"),
  ];

  static List<DropdownItemModel> typeLocation = [
    DropdownItemModel(id: "1", label: "Office"),
    DropdownItemModel(id: "2", label: "Warehouse"),
    DropdownItemModel(id: "3", label: "Retail Store"),
    DropdownItemModel(id: "4", label: "Factory"),
    DropdownItemModel(id: "4", label: "Other  "),
  ];
  static List<DropdownItemModel> languange = [
    DropdownItemModel(id: "1", label: "Indonesia"),
  ];
  static List<DropdownItemModel> timeZone = [
    DropdownItemModel(id: "1", label: "WIB (UTC+7)"),
  ];

  static List<DropdownItemModel> nullData = [
    DropdownItemModel(id: "1", label: ""),
  ];
}
