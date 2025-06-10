class ProfileDataEntity {
  final String profileImage;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String email;
  final DateTime burthdayDate;

  ProfileDataEntity({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.burthdayDate,
  });
}
