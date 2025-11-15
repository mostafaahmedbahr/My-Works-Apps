
import '../../data/models/profile_data_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetProfileDataLoadingState extends HomeStates {}

class GetProfileDataSuccessState extends HomeStates {
  final ProfileDataModel profileData;
    GetProfileDataSuccessState({required this.profileData});
}

class GetProfileDataErrorState extends HomeStates {
  final String message;

    GetProfileDataErrorState({required this.message});
}