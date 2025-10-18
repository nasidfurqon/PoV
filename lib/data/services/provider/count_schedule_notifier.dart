import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/count_service.dart';

class CountState {
  final int onGoing;
  final int waiting;
  final int finish;

  const CountState({
    required this.onGoing,
    required this.waiting,
    required this.finish,
  });

  CountState copyWith({
    int? onGoing,
    int? waiting,
    int? finish,
  }) {
    return CountState(
      onGoing: onGoing ?? this.onGoing,
      waiting: waiting ?? this.waiting,
      finish: finish ?? this.finish,
    );
  }

  static const initial = CountState(onGoing: 0, waiting: 0, finish: 0);
}

final countNotifierProvider =
AsyncNotifierProvider<CountNotifier, CountState>(CountNotifier.new);

class CountNotifier extends AsyncNotifier<CountState> {
  @override
  Future<CountState> build() async {
    ref.keepAlive();
    return await _loadCounts();
  }

  Future<CountState> _loadCounts() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    if (userId == null) return CountState.initial;

    final cntOnGoing = await CountService.countAdminStatus('OnProgress');
    final cntWaiting = await CountService.countAdminStatus('Scheduled');
    final cntFinish = await CountService.countAdminStatus('Completed');

    return CountState(
      onGoing: cntOnGoing,
      waiting: cntWaiting,
      finish: cntFinish,
    );
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadCounts());
  }
}
