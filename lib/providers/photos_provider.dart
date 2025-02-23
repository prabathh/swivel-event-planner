import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/api_service.dart';

// Create a provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Fetch Photos Provider
final photosProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchPhotos();
});
