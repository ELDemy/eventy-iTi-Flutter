import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_hub/domain/models/app_user.dart';

class AppUserModel {
  const AppUserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.about,
    this.followingCount = 0,
    this.followersCount = 0,
  });

  final String uid;
  final String fullName;
  final String email;
  final String? photoUrl;
  final String? about;
  final int followingCount;
  final int followersCount;

  factory AppUserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? const <String, dynamic>{};
    return AppUserModel(
      uid: snapshot.id,
      fullName: data['fullName'] as String? ?? 'EventHub User',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
      about: data['about'] as String?,
      followingCount: data['followingCount'] as int? ?? 0,
      followersCount: data['followersCount'] as int? ?? 0,
    );
  }

  factory AppUserModel.fromEntity(AppUser user) {
    return AppUserModel(
      uid: user.uid,
      fullName: user.fullName,
      email: user.email,
      photoUrl: user.photoUrl,
      about: user.about,
      followingCount: user.followingCount,
      followersCount: user.followersCount,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
      'about': about,
      'followingCount': followingCount,
      'followersCount': followersCount,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, Object?> toCreateJson() {
    return {
      ...toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  AppUser toEntity() {
    return AppUser(
      uid: uid,
      fullName: fullName,
      email: email,
      photoUrl: photoUrl,
      about: about,
      followingCount: followingCount,
      followersCount: followersCount,
    );
  }
}
