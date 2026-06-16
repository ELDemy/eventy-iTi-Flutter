import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_hub/data/models/app_user_model.dart';
import 'package:events_hub/domain/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> authStateChanges();

  User? get currentFirebaseUser;

  Future<AppUserModel?> getCurrentUserProfile();

  Future<AppUserModel> signIn({
    required String email,
    required String password,
  });

  Future<AppUserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentFirebaseUser => _firebaseAuth.currentUser;

  @override
  Future<AppUserModel?> getCurrentUserProfile() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return _profileFor(firebaseUser);
  }

  @override
  Future<AppUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw FirebaseAuthException(
        code: 'missing-user',
        message: 'Sign in succeeded but no user was returned.',
      );
    }
    return _profileFor(firebaseUser);
  }

  @override
  Future<AppUserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      throw FirebaseAuthException(
        code: 'missing-user',
        message: 'Sign up succeeded but no user was returned.',
      );
    }

    await firebaseUser.updateDisplayName(fullName);
    final profile = AppUser(
      uid: firebaseUser.uid,
      fullName: fullName,
      email: email,
      about: 'Tell people about yourself and the events you love.',
    );
    final model = AppUserModel.fromEntity(profile);
    await _users.doc(firebaseUser.uid).set(model.toCreateJson());
    return model;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<AppUserModel> _profileFor(User firebaseUser) async {
    final doc = await _users.doc(firebaseUser.uid).get();
    if (doc.exists) return AppUserModel.fromFirestore(doc);

    final fallback = AppUser(
      uid: firebaseUser.uid,
      fullName: firebaseUser.displayName ?? 'EventHub User',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
      about: 'Tell people about yourself and the events you love.',
    );
    final model = AppUserModel.fromEntity(fallback);
    await _users.doc(firebaseUser.uid).set(model.toCreateJson());
    return model;
  }
}
