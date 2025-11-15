import 'package:dartz/dartz.dart';
import 'package:my_works_apps/features/home/data/models/profile_data_model.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, ProfileDataModel>> getProfileData();
}