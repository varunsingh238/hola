class UserModel {
  final String username;
  final String uid;
  final String profileImageUrl;
  final String phoneNumber;
  final List<String> groupId;

  UserModel(
      {required this.username,
      required this.uid,
      required this.profileImageUrl,
      required this.phoneNumber,
      required this.groupId});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['usermodel'] ?? '',
      uid: map['uid'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(
        map['groupId'],
      ),
    );
  }
}
