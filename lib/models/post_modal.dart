class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Convert Firestore document to Post
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }
}