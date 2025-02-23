import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:event_planner_app/utils/logging.dart';

class ImageDecoder {
  /// Converts Base64 string to a File
  static Future<File?> convertBase64ToFile(String base64String) async {
    try {
      // Remove the metadata part (if exists)
      final splitData = base64String.split(",");
      final String pureBase64 =
          splitData.length > 1 ? splitData[1] : base64String;

      // Decode Base64 to bytes
      Uint8List imageBytes = base64Decode(pureBase64);

      // Get the temp directory
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/profile_image.jpg');

      // Write image bytes to file
      await tempFile.writeAsBytes(imageBytes);

      return tempFile;
    } catch (e) {
      LogService.error("Error converting Base64 to File: $e");
      throw Exception("Error converting Base64 to File: $e");
    }
  }
}
