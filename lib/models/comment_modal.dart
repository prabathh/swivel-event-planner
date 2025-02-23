class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  // Convert Firestore document to Comment
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      postId: map['postId'],
      id: map['id'],
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }
}