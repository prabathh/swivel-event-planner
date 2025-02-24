// Photo Model (Only Required Fields)
class Photo {
  final String id;
  final String author;
  final String url;
  final String downloadUrl;

  Photo({
    required this.id,
    required this.author,
    required this.url,
    required this.downloadUrl,
  });

  // Factory method to create a Photo from JSON
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }
}
