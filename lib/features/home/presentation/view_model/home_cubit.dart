import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_works_apps/features/home/data/models/profile_data_model.dart';
import '../../data/repos/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(HomeInitialState());

  ProfileDataModel? profileDataModel;
  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());
    final result = await homeRepository.getProfileData();
    result.fold(
          (failure) => emit(GetProfileDataErrorState(message: failure.message.toString())),
          (profileData){
            profileDataModel = profileData;
            emit(GetProfileDataSuccessState(profileData: profileData));
          },
    );
  }
}