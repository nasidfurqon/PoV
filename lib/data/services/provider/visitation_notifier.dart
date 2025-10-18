import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pov2/data/models/jobList_model.dart';
import 'package:pov2/data/models/trVisitationSchedule_model.dart';
import 'package:pov2/data/services/api/get_admin_service.dart';

final visitationTodayProvider =
AsyncNotifierProvider<VisitationTodayNotifier, List<JobListModel>>(VisitationTodayNotifier.new);

class VisitationTodayNotifier extends AsyncNotifier<List<JobListModel>> {
  @override
  Future<List<JobListModel>> build() async {
    ref.keepAlive();
    return await GetAdminService.getListJobTodayNotCompleted();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => GetAdminService.getListJobToday());
  }
}

final visitationCompletedProvider =
AsyncNotifierProvider<VisitationCompletedNotifier, List<JobListModel>>(VisitationCompletedNotifier.new);

class VisitationCompletedNotifier extends AsyncNotifier<List<JobListModel>> {
  @override
  Future<List<JobListModel>> build() async {
    ref.keepAlive();
    return await GetAdminService.getListJobCompleted();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => GetAdminService.getListJobCompleted());
  }
}

final visitationFullProvider =
AsyncNotifierProvider<VisitationFullNotifier, List<JobListModel>>(VisitationFullNotifier.new);

class VisitationFullNotifier extends AsyncNotifier<List<JobListModel>> {
  @override
  Future<List<JobListModel>> build() async {
    ref.keepAlive();
    return await GetAdminService.getListJob();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => GetAdminService.getListJob());
  }
}