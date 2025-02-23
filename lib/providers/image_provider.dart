import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/api_service.dart';

// Create a provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Create a provider for fetching images using ApiService
final imageSliderProvider = FutureProvider<List<String>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final imagesData = await apiService.fetchImages();
  return imagesData; // Directly returning the list of URLs as strings
});

// Create a StateProvider to track the current index of the image slider
final imageSliderIndexProvider = StateProvider<int>((ref) => 0);
