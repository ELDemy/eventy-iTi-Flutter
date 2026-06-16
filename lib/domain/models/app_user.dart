import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
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

  @override
  List<Object?> get props => [
        uid,
        fullName,
        email,
        photoUrl,
        about,
        followingCount,
        followersCount,
      ];
}
