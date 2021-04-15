class UserModel {
  final String displayedName;
  final String userEmail;
  final String userId;
  final String userImage;

  final int userTotalPoints;

  final Map<String, Map<String, dynamic>> userCategories;
  final List<Map> userNotifications;

  UserModel(this.displayedName, this.userEmail, this.userId, this.userImage,
      this.userTotalPoints, this.userCategories, this.userNotifications);
}
