// Organizer Model (Only Required Fields)
class Organizer {
  final int id;
  final String name;
  final String username;
  final String email;

  Organizer({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  // Factory method to create an Organizer from JSON
  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}
