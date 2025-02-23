import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/api_service.dart';

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Provider for event organizers list
final organizersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchOrganizers();
});
