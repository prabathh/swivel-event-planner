import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/api_service.dart';
import 'package:event_planner_app/models/organizer_model.dart';

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Provider for event organizers list
final organizersProvider = FutureProvider<List<Organizer>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchOrganizers();
});
