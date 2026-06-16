import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_hub/data/datasources/auth_local_data_source.dart';
import 'package:events_hub/data/datasources/auth_remote_data_source.dart';
import 'package:events_hub/data/datasources/favorites_remote_data_source.dart';
import 'package:events_hub/data/repositories/auth_repository_impl.dart';
import 'package:events_hub/data/repositories/favorites_repository_impl.dart';
import 'package:events_hub/domain/repositories/auth_repository.dart';
import 'package:events_hub/domain/repositories/favorites_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class AppDependencies {
  static late final AuthRepository authRepository;
  static late final FavoritesRepository favoritesRepository;

  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    authRepository = AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSourceImpl(
        firebaseAuth: auth,
        firestore: firestore,
      ),
      localDataSource: AuthLocalDataSourceImpl(preferences),
    );

    favoritesRepository = FavoritesRepositoryImpl(
      FavoritesRemoteDataSourceImpl(firestore),
    );
  }
}
