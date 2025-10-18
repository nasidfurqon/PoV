import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/data/services/api/count_service.dart';

class LocationCountState {
  final int active;
  final int total;

  const LocationCountState({
    required this.active,
    required this.total,
  });

  LocationCountState copyWith({
    int? active,
    int? inactive,
    int? total,
  }) {
    return LocationCountState(
      active: active ?? this.active,
      total: total ?? this.total,
    );
  }

  static const initial = LocationCountState(active: 0, total: 0);
}

final locationCountNotifierProvider =
AsyncNotifierProvider<LocationCountNotifier, LocationCountState>(
    LocationCountNotifier.new);

class LocationCountNotifier extends AsyncNotifier<LocationCountState> {
  @override
  Future<LocationCountState> build() async {
    ref.keepAlive();
    return await _loadCounts();
  }

  Future<LocationCountState> _loadCounts() async {
    try {
      final activeCount = await CountService.countAdminActiveLocationActive();
      final totalCount = await CountService.countAdminLocation();

      return LocationCountState(
        active: activeCount,
        total: totalCount,
      );
    } catch (e) {
      throw Exception('Gagal mengambil data lokasi: $e');
    }
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadCounts());
  }
}
