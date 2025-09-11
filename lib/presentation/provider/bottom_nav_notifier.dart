import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavNotifier extends ChangeNotifier {
  late PageController controller;
  int index = 0;

  BottomNavNotifier() {
    controller = PageController(initialPage: index, keepPage: true);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void changeIndex(int value) {
    index = value;
    controller.jumpToPage(value);
    notifyListeners();
  }
}

final bottomNavNotifier = ChangeNotifierProvider.autoDispose<BottomNavNotifier>(
        (ref) => BottomNavNotifier());
