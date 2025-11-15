import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_works_apps/features/home/data/models/profile_data_model.dart';

import '../../../../core/errors/failure.dart';
import 'home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestore firestore;

  HomeRepositoryImpl({required this.firestore});

  @override
  Future<Either<Failure, ProfileDataModel>> getProfileData() async {
    try {
      final doc = await firestore.collection('profileData').doc('lGPn38k7VjZzg5spwGrB').get();
      if (!doc.exists) {
        return Left(ServerFailure(message: 'Profile document not found'));
      }

      final profileData = ProfileDataModel.fromFirestore(doc);
      return Right(profileData);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: 'Firebase Error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected Error: ${e.toString()}'));
    }
  }
}