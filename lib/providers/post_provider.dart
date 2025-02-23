import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/models/post_modal.dart';
import 'package:event_planner_app/models/comment_modal.dart';
import 'package:event_planner_app/services/api_service.dart';

// Create a provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Fetch Post Provider
final postProvider = FutureProvider<List<Post>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchPosts();
});

// Fetch Comment Provider
final commentProvider = FutureProvider.family<List<Comment>, int>((ref, postId) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchComments(postId);
});