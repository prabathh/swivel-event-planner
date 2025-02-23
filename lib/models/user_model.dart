class UserModel {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? imageUrl;
  final bool firstTimeLogin;

  UserModel({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.imageUrl,
    required this.firstTimeLogin,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      imageUrl: data['imageUrl'],
      firstTimeLogin: data['firstTimeLogin'] ?? true,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, imageUrl: $imageUrl, firstTimeLogin: $firstTimeLogin)';
  }
}