import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_planner_app/models/post_modal.dart';
import 'package:event_planner_app/models/comment_modal.dart';
import 'package:event_planner_app/utils/logging.dart';

class ApiService {
  // Base Url
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final String baseImageUrl = 'https://picsum.photos/v2/list';

  // Update constructor to allow dependency injection
  final http.Client client;
  ApiService({http.Client? client}) : client = client ?? http.Client();

  //Fetch images
  Future<List<String>> fetchImages() async {
    try {
      LogService.info("Fetching images from $baseImageUrl...");
      final response = await client.get(Uri.parse(baseImageUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        LogService.debug("Successfully fetched ${data.length} images.");
        return data
            .take(10)
            .map((item) => item['download_url'] as String)
            .toList();
      } else {
        LogService.warning(
          "Failed to fetch images. Status Code: ${response.statusCode}",
        );
        throw Exception('Failed to load images');
      }
    } catch (error) {
      LogService.error("Error fetching images: ${error.toString()}");
      throw Exception('Failed to load images');
    } finally {
      client.close();
    }
  }

  // Fetch event organizers
  Future<List<Map<String, dynamic>>> fetchOrganizers() async {
    try {
      LogService.info("Fetching event organizers from $baseUrl/users...");
      final response = await client.get(Uri.parse('$baseUrl/users'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        LogService.debug(
          "Successfully fetched ${data.length} event organizers.",
        );
        return List<Map<String, dynamic>>.from(data);
      } else {
        LogService.warning(
          "Failed to fetch event organizers. Status Code: ${response.statusCode}",
        );
        throw Exception('Failed to load event organizers');
      }
    } catch (error) {
      LogService.error("Error fetching event organizers: ${error.toString()}");
      throw Exception('Failed to load event organizers');
    } finally {
      client.close();
    }
  }

  // Fetch the first 10 photos
  Future<List<Map<String, dynamic>>> fetchPhotos() async {
    try {
      LogService.info("Fetching first 10 photos from $baseImageUrl...");
      final response = await client.get(Uri.parse(baseImageUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        LogService.debug(
          "Successfully fetched first 10 photos ${data.toString()}",
        );
        return data
            .take(10)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        LogService.warning(
          "Failed to fetch first 10 photos. Status Code: ${response.statusCode}",
        );
        throw Exception('Failed to load first 10 photos');
      }
    } catch (error) {
      LogService.error("Error fetching first 10 photos: ${error.toString()}");
      throw Exception('Failed to load first 10 photos');
    } finally {
      client.close();
    }
  }

  // Fetch posts
  Future<List<Post>> fetchPosts() async {
    try {
      LogService.info("Fetching posts from $baseUrl/posts...");
      final response = await client.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        LogService.debug("Successfully fetched ${data.length} posts.");
        return data.map((post) => Post.fromMap(post)).toList();
      } else {
        LogService.warning(
          "Failed to fetch posts. Status Code: ${response.statusCode}",
        );
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      LogService.error("Error fetching posts: ${error.toString()}");
      throw Exception('Failed to load posts');
    }
  }

  // Fetch comments
  Future<List<Comment>> fetchComments(int postId) async {
    try {
      LogService.info(
        "Fetching comments from $baseUrl/comments?postId=$postId...",
      );
      final response = await client.get(
        Uri.parse('$baseUrl/comments?postId=$postId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        LogService.debug("Successfully fetched ${data.length} comments.");
        return data.map((comment) => Comment.fromMap(comment)).toList();
      } else {
        LogService.warning(
          "Failed to fetch comments. Status Code: ${response.statusCode}",
        );
        throw Exception('Failed to load comments');
      }
    } catch (error) {
      LogService.error("Error fetching comments: ${error.toString()}");
      throw Exception('Failed to load comments');
    }
  }
}
