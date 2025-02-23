import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/models/user_model.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:event_planner_app/utils/logging.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  // Fetch user data from Firestore
  Future<void> fetchUserData(String uid) async {
    try {
      final userData = await AuthService().fetchUserProfile(uid);
      
      if (userData != null) {
        state = UserModel.fromMap(userData, uid);
      } else {
        // If no user data found, assume first-time login
        state = UserModel(uid: uid, firstTimeLogin: true);
      }
    } catch (e) {
      LogService.error("Error fetching user data UserNotifier: $e");
      throw Exception('Error fetching user data UserNotifier: $e');
    }
  }

  // Clear user data on logout
  void clearUserData() {
    state = null;
  }
}

// Create a Riverpod provider for UserNotifier
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});
