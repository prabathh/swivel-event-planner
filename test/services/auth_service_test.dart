import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  UserCredential,
  User,
  CollectionReference<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  DocumentSnapshot<Map<String, dynamic>>,
])
void main() {
  late AuthService authService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;

  setUp(() {
    // Initialize mocks
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    // Inject mocks into AuthService via constructor
    authService = AuthService(
      auth: mockFirebaseAuth,
      firestore: mockFirebaseFirestore,
    );

    // Mock Firestore behavior
    when(
      mockFirebaseFirestore.collection('users'),
    ).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
  });

  // Group of test cases for signUp
  group('AuthService', () {
    test('signUp returns a User when sign-up is successful', () async {
      // Arrange
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);

      // Act
      final result = await authService.signUp(
        'test@example.com',
        'password123',
      );

      // Assert
      expect(result, equals(mockUser));
      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
    });

    test(
      'signUp throws an exception when FirebaseAuthException occurs',
      () async {
        // Arrange
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenThrow(
          FirebaseAuthException(
            message: 'Email already in use',
            code: 'email-already-in-use',
          ),
        );

        // Act & Assert
        expect(
          () => authService.signUp('test@example.com', 'password123'),
          throwsA(isA<FirebaseAuthException>()),
        );

        verify(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    test(
      'signUp throws an exception when an unexpected error occurs',
      () async {
        // Arrange
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
          () => authService.signUp('test@example.com', 'password123'),
          throwsA('An unexpected error occurred during sign-up.'),
        );

        verify(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );
  });

  // Group of test cases for logIn
  group('AuthService - logIn', () {
    test('logIn returns a User when login is successful', () async {
      // Arrange
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);

      // Act
      final result = await authService.logIn('test@example.com', 'password123');

      // Assert
      expect(result, equals(mockUser));
      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
    });

    test(
      'logIn throws an exception when FirebaseAuthException occurs',
      () async {
        // Arrange
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenThrow(
          FirebaseAuthException(
            message: 'Invalid email or password',
            code: 'invalid-credentials',
          ),
        );

        // Act & Assert
        expect(
          () => authService.logIn('test@example.com', 'password123'),
          throwsA('An error occurred during login.'),
        );

        verify(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    test('logIn throws an exception when an unexpected error occurs', () async {
      // Arrange
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => authService.logIn('test@example.com', 'password123'),
        throwsA('An unexpected error occurred during login.'),
      );

      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
    });
  });

  // Group of test cases for logOut
  group('AuthService - logOut', () {
    test('logOut successfully logs the user out', () async {
      // Arrange
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      // Act
      await authService.logOut();

      // Assert
      verify(mockFirebaseAuth.signOut()).called(1);
    });

    test(
      'logOut throws an error and logs it when an exception occurs',
      () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenThrow(Exception('Logout error'));

        // Act & Assert
        expect(() => authService.logOut(), throwsA(isA<String>()));

        // Verify that the error is logged
        verify(mockFirebaseAuth.signOut()).called(1);
      },
    );
  });

  // Group of test cases for logOut updates and create user profile
  group('AuthService - User Profile', () {
    const String testUid = 'testUser123';
    final Map<String, dynamic> testUserData = {
      'name': 'Test User',
      'email': 'test@example.com',
    };

    test('updateUserProfile successfully updates user profile', () async {
      // Arrange
      when(
        mockFirebaseFirestore.collection('users'),
      ).thenReturn(mockCollectionReference);
      when(
        mockCollectionReference.doc(testUid),
      ).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(testUserData)).thenAnswer((_) async {});

      // Act
      await authService.updateUserProfile(testUid, testUserData);

      // Assert
      verify(mockDocumentReference.update(testUserData)).called(1);
    });

    test(
      'updateUserProfile throws an error and logs it when an exception occurs',
      () async {
        // Arrange
        when(
          mockFirebaseFirestore.collection('users'),
        ).thenReturn(mockCollectionReference);
        when(
          mockCollectionReference.doc(testUid),
        ).thenReturn(mockDocumentReference);
        when(
          mockDocumentReference.update(testUserData),
        ).thenThrow(Exception('Update error'));

        // Act & Assert
        expect(
          () => authService.updateUserProfile(testUid, testUserData),
          throwsA(isA<String>()),
        );

        // Verify error logging
        verify(mockDocumentReference.update(testUserData)).called(1);
      },
    );

    test('createUserProfile successfully creates a user profile', () async {
      // Arrange
      when(
        mockFirebaseFirestore.collection('users'),
      ).thenReturn(mockCollectionReference);
      when(
        mockCollectionReference.doc(testUid),
      ).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(testUserData)).thenAnswer((_) async {});

      // Act
      await authService.createUserProfile(testUid, testUserData);

      // Assert
      verify(mockDocumentReference.set(testUserData)).called(1);
    });

    test(
      'createUserProfile throws an error and logs it when an exception occurs',
      () async {
        // Arrange
        when(
          mockFirebaseFirestore.collection('users'),
        ).thenReturn(mockCollectionReference);
        when(
          mockCollectionReference.doc(testUid),
        ).thenReturn(mockDocumentReference);
        when(
          mockDocumentReference.set(testUserData),
        ).thenThrow(Exception('Create error'));

        // Act & Assert
        expect(
          () => authService.createUserProfile(testUid, testUserData),
          throwsA(isA<String>()),
        );

        // Verify error logging
        verify(mockDocumentReference.set(testUserData)).called(1);
      },
    );
  });

  // Group of test cases for fetch user profile
  group('fetchUserProfile', () {
    test('should return user profile data when document exists', () async {
      // Arrange
      const userId = 'testUserId';
      final testData = {'name': 'John Doe', 'email': 'john@example.com'};

      when(
        mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn(testData);

      // Act
      final result = await authService.fetchUserProfile(userId);

      // Assert
      expect(result, equals(testData));
      verify(mockFirebaseFirestore.collection('users')).called(1);
      verify(mockCollectionReference.doc(userId)).called(1);
      verify(mockDocumentReference.get()).called(1);
    });

    test('should return null when document does not exist', () async {
      // Arrange
      const userId = 'nonExistentUser';

      when(
        mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);
      when(mockDocumentSnapshot.data()).thenReturn(null);

      // Act
      final result = await authService.fetchUserProfile(userId);

      // Assert
      expect(result, isNull);
    });

    test('should throw an exception when Firestore throws an error', () async {
      // Arrange
      const userId = 'errorUser';
      when(mockDocumentReference.get()).thenThrow(Exception('Firestore error'));

      // Act & Assert
      expect(
        () => authService.fetchUserProfile(userId),
        throwsA(
          isA<String>().having(
            (e) => e,
            'error message',
            contains('An unexpected error occurred during fetch user profile'),
          ),
        ),
      );
    });
  });
}