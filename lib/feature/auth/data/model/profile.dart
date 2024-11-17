class Profile {
  final int userId;
  final String firstName;
  final String lastName;
  final String createdAt;
  final String updatedAt;

  Profile(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.createdAt,
      required this.updatedAt});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        userId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
