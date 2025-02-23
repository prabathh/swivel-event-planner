import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:event_planner_app/services/api_service.dart';
import 'package:event_planner_app/models/post_modal.dart';
import 'package:event_planner_app/models/comment_modal.dart';
import 'api_service_test.mocks.dart';

// Add this annotation to generate a mock for http.Client
@GenerateMocks([http.Client])
void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    // Create a mock HTTP client
    mockClient = MockClient();
    // Inject the mock client into ApiService
    apiService = ApiService(client: mockClient);
  });

  // Group of test cases for fetchImages
  group('fetchImages', () {
    test(
      'returns a list of image URLs if the http call completes successfully',
      () async {
        // Arrange
        final mockResponse = '''
      [
        {"download_url": "https://picsum.photos/id/0/5000/3333"},
        {"download_url": "https://picsum.photos/id/1/5000/3333"}
      ]
      ''';

        // Simulate a successful HTTP response
        when(
          mockClient.get(Uri.parse('https://picsum.photos/v2/list')),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await apiService.fetchImages();

        // Assert
        expect(result, isA<List<String>>());
        expect(result.length, 2);
        expect(result[0], 'https://picsum.photos/id/0/5000/3333');
        expect(result[1], 'https://picsum.photos/id/1/5000/3333');
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        // Arrange
        // Simulate an error HTTP response
        when(
          mockClient.get(Uri.parse('https://picsum.photos/v2/list')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(() => apiService.fetchImages(), throwsException);
      },
    );
  });

  // Group of test cases for fetchOrganizers
  group('fetchOrganizers', () {
    test(
      'returns a list of organizers if the http call completes successfully',
      () async {
        // Arrange
        final mockResponse = '''
      [
        {"id": 1, "name": "John Doe", "email": "john@example.com"},
        {"id": 2, "name": "Jane Smith", "email": "jane@example.com"}
      ]
      ''';

        // Simulate a successful HTTP response
        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/users'),
          ),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await apiService.fetchOrganizers();

        // Assert
        expect(result, isA<List<Map<String, dynamic>>>());
        expect(result.length, 2);
        expect(result[0]['name'], 'John Doe');
        expect(result[1]['email'], 'jane@example.com');
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        // Arrange
        // Simulate an error HTTP response
        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/users'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(() => apiService.fetchOrganizers(), throwsException);
      },
    );
  });

  // Group of test cases for fetchPhotos
  group('fetchPhotos', () {
    test(
      'returns a list of photos if the http call completes successfully',
      () async {
        // Arrange
        final mockResponse = '''
      [
        {"id": "0", "author": "John Doe", "url": "https://picsum.photos/id/0/5000/3333"},
        {"id": "1", "author": "Jane Smith", "url": "https://picsum.photos/id/1/5000/3333"}
      ]
      ''';

        when(
          mockClient.get(Uri.parse('https://picsum.photos/v2/list')),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await apiService.fetchPhotos();

        // Assert
        expect(result, isA<List<Map<String, dynamic>>>());
        expect(result.length, 2);
        expect(result[0]['author'], 'John Doe');
        expect(result[1]['url'], 'https://picsum.photos/id/1/5000/3333');
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        // Arrange
        when(
          mockClient.get(Uri.parse('https://picsum.photos/v2/list')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(() => apiService.fetchPhotos(), throwsException);
      },
    );
  });

  // Group of test cases for fetchPosts
  group('fetchPosts', () {
    test(
      'returns a list of posts if the http call completes successfully',
      () async {
        // Arrange
        final mockResponse = '''
      [
        {"userId": 1, "id": 1, "title": "Test Title 1", "body": "Test Body 1"},
        {"userId": 2, "id": 2, "title": "Test Title 2", "body": "Test Body 2"}
      ]
      ''';

        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          ),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await apiService.fetchPosts();

        // Assert
        expect(result, isA<List<Post>>());
        expect(result.length, 2);
        expect(result[0].title, 'Test Title 1');
        expect(result[1].body, 'Test Body 2');
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        // Arrange
        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(() => apiService.fetchPosts(), throwsException);
      },
    );
  });

  // Group of test cases for fetchComments
  group('fetchComments', () {
    test(
      'returns a list of comments if the http call completes successfully',
      () async {
        // Arrange
        final mockResponse = '''
      [
        {"postId": 1, "id": 1, "name": "John Doe", "email": "john@example.com", "body": "Test Comment 1"},
        {"postId": 1, "id": 2, "name": "Jane Smith", "email": "jane@example.com", "body": "Test Comment 2"}
      ]
      ''';

        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=1'),
          ),
        ).thenAnswer((_) async => http.Response(mockResponse, 200));

        // Act
        final result = await apiService.fetchComments(1);

        // Assert
        expect(result, isA<List<Comment>>());
        expect(result.length, 2);
        expect(result[0].name, 'John Doe');
        expect(result[1].body, 'Test Comment 2');
      },
    );

    test(
      'throws an exception if the http call completes with an error',
      () async {
        // Arrange
        when(
          mockClient.get(
            Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=1'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // Act & Assert
        expect(() => apiService.fetchComments(1), throwsException);
      },
    );
  });
}
