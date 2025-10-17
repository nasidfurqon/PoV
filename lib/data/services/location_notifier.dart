import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/data/models/mtLocation_model.dart';
import 'package:pov2/data/services/get_admin_service.dart';

final locationProvider =
AsyncNotifierProvider<LocationNotifier, List<MTLocationModel>>(LocationNotifier.new);

class LocationNotifier extends AsyncNotifier<List<MTLocationModel>> {
  @override
  Future<List<MTLocationModel>> build() async {
    ref.keepAlive();
    return await GetAdminService.getListLocation();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => GetAdminService.getListLocation());
  }
}
