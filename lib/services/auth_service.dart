import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/utils/logging.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  // Constructor for dependency injection
  AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      LogService.info("Attempting to sign up user");
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      LogService.debug("User signed up successfully");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      LogService.error("An error occurred during sign-up.: ${e.message}");
      rethrow;
    } catch (error) {
      LogService.error("An unexpected error occurred during sign-up");
      throw 'An unexpected error occurred during sign-up.';
    }
  }
  

  // Log in with email and password
  Future<User?> logIn(String email, String password) async {
    try {
      LogService.info("Attempting to log in user");
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LogService.debug("User log in successfully");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      LogService.error("An error occurred during login.: ${e.message}");
      throw 'An error occurred during login.';
    } catch (error) {
      LogService.error("An unexpected error occurred during login");
      throw 'An unexpected error occurred during login.';
    }
  }

  // Log out
  Future<void> logOut() async {
    try {
      await _auth.signOut();
      LogService.debug("User log out successfully");
    } catch (error) {
      LogService.error("An unexpected error occurred during logout");
      throw 'An unexpected error occurred during logout.';
    }
  }

  // Update User Profile
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      LogService.info("Attempting to update user profile");
      await _firestore.collection('users').doc(uid).update(data);
      LogService.debug("User profile update successfully");
    } catch (error) {
      LogService.error("An unexpected error occurred during update user profile");
      throw 'An unexpected error occurred during update user profile.';
    }
  }

  // Create User Profile
  Future<void> createUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      LogService.info("Attempting to create user profile");
      await _firestore.collection('users').doc(uid).set(data);
      LogService.debug("User profile create successfully");
    } catch (error) {
      LogService.error("An unexpected error occurred during create user profile");
      throw 'An unexpected error occurred during create user profile.';
    }
  }

  // Fetch User Profile data
  Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
    try {
      LogService.info("Attempting to fetch user profile");
      final doc = await _firestore.collection('users').doc(userId).get();
      LogService.debug("User profile fetch successfully");
      return doc.data();
    } catch (error) {
      LogService.error("An unexpected error occurred during fetch user profile");
      throw 'An unexpected error occurred during fetch user profile.';
    }
  }
}