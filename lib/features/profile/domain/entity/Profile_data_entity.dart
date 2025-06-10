class ProfileDataEntity {
  String profileImage;
  String firstName;
  String lastName;
  String username;
  String phoneNumber;
  String email;
  DateTime burthdayDate;

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
