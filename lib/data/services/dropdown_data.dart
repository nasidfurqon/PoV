import '../models/dropdown_model.dart';

class DropdownData{
  static List<DropdownItemModel> photoType = [
    DropdownItemModel(id: "1", label: "General Evidence"),
    DropdownItemModel(id: "2", label: "Before State"),
    DropdownItemModel(id: "3", label: "After State"),
    DropdownItemModel(id: "4", label: "Issue/Problem"),
    DropdownItemModel(id: "5", label: "Task Completion"),
  ];

  static List<DropdownItemModel> priorityData = [
    DropdownItemModel(id: "1", label: "Low"),
    DropdownItemModel(id: "2", label: "Normal"),
    DropdownItemModel(id: "3", label: "High"),
    DropdownItemModel(id: "4", label: "Urgent"),
  ];

  static List<DropdownItemModel> typeLocation = [
    DropdownItemModel(id: "1", label: "Office"),
    DropdownItemModel(id: "2", label: "Warehouse"),
    DropdownItemModel(id: "3", label: "Retail Store"),
    DropdownItemModel(id: "4", label: "Factory"),
    DropdownItemModel(id: "4", label: "Other  "),
  ];
}
