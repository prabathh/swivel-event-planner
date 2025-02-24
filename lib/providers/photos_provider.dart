import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/api_service.dart';
import 'package:event_planner_app/models/photo_model .dart';

// Create a provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Fetch Photos Provider
final photosProvider = FutureProvider<List<Photo>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchPhotos();
});
