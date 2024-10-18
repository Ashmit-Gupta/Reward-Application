class UserData {
  final String id; // Firebase UserData ID
  final String email; // UserData's email
  final String displayName; // UserData's display name (if available)
  final String photoURL; // UserData's profile picture URL (if available)

  UserData({
    required this.id,
    required this.email,
    this.displayName = '',
    this.photoURL = '',
  });

  // Factory constructor to create a UserData instance from a JSON map
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? '',
      photoURL: json['photoURL'] as String? ?? '',
    );
  }

  // Method to convert UserData instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
