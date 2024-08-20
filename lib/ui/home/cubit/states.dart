import '../../../domain/entities/CountriesDataEntity.dart';
import '../../../domain/entities/ProfileDataEntity.dart';
import '../../../domain/entities/ServicesDataEntity.dart';

abstract class HomeScreenState {}

class HomeInitState extends HomeScreenState {}

class ChangeNavBarState extends HomeScreenState {}

class CountriesSuccessState extends HomeScreenState {
  final CountriesDataEntity countriesData;

  CountriesSuccessState({required this.countriesData});
}

class CountriesErrorState extends HomeScreenState {
  final String errorMessage;

  CountriesErrorState({required this.errorMessage});
}

class CountriesLoadingState extends HomeScreenState {}

class ServicesLoadingState extends HomeScreenState {}

class ServicesErrorState extends HomeScreenState {
  final String errorMessage;

  ServicesErrorState({required this.errorMessage});
}

class PopularServicesLoadingState extends HomeScreenState {}

class PopularServicesErrorState extends HomeScreenState {
  final String errorMessage;

  PopularServicesErrorState({required this.errorMessage});
}

class ServicesSuccessState extends HomeScreenState {
  final ServicesDataEntity servicesData;

  ServicesSuccessState({required this.servicesData});
}

class PopularServicesSuccessState extends HomeScreenState {
  final ServicesDataEntity popularServicesData;

  PopularServicesSuccessState({required this.popularServicesData});
}

class CombinedServicesSuccessState extends HomeScreenState {
  final ServicesDataEntity servicesData;
  final ServicesDataEntity popularServicesData;

  CombinedServicesSuccessState({
    required this.servicesData,
    required this.popularServicesData,
  });
}

class ProfileLoadingState extends HomeScreenState {}

class ProfileSuccessState extends HomeScreenState {
  final ProfileDataEntity profileData;
  final String password;

  ProfileSuccessState({required this.profileData, required this.password});
}

class ProfileErrorState extends HomeScreenState {
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}
