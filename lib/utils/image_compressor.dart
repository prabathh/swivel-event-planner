import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:event_planner_app/utils/logging.dart';

class ImageCompressor {
  // Compresses an image and returns the Base64 string
  static Future<String?> compressImageToBase64(
    File imageFile, {
    int quality = 50,
  }) async {
    try {
      final Uint8List? compressedImage =
          await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        // Compression quality (0-100)
        quality: quality,
        // Choose JPEG for better compression
        format: CompressFormat.jpeg,
      );

      if (compressedImage == null) {
        LogService.error("Image compression failed");
        throw Exception("Image compression failed");
      }

      // Convert compressed image to Base64
      String compressedBase64 = "data:image/jpeg;base64,${base64Encode(compressedImage)}";

      return compressedBase64;
    } catch (e) { 
      LogService.error("Error compressing image: $e");
      throw Exception("Error compressing image: $e");
    }
  }
}
