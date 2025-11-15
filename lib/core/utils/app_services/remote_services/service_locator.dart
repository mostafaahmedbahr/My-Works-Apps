import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../features/home/data/repos/home_repo_imple.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerFactory<HomeRepositoryImpl>(
    () => HomeRepositoryImpl(firestore: getIt<FirebaseFirestore>()),
  );
}
