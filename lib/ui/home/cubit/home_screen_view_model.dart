import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kafiil_test/ui/home/cubit/states.dart';

import '../../../domain/use_cases/get_countries_use_case.dart';
import '../../../domain/use_cases/get_popular_services_use_case.dart';
import '../../../domain/use_cases/get_profile_use_case.dart';
import '../../../domain/use_cases/get_services_use_case.dart';
import '../tabs/countires/countries.dart';
import '../tabs/services/services.dart';
import '../tabs/who_am_i/who_am_i.dart';

class HomeScreenViewModel extends Cubit<HomeScreenState> {
  HomeScreenViewModel({
    required this.getCountriesUseCase,
    required this.getServicesUseCase,
    required this.getPopularServicesUseCase,
    required this.getProfileUseCase,
  }) : super(HomeInitState());

  final GetCountriesUseCase getCountriesUseCase;
  final GetServicesUseCase getServicesUseCase;
  final GetPopularServicesUseCase getPopularServicesUseCase;
  final GetProfileUseCase getProfileUseCase;

  int selectedIndex = 0;
  List<Widget> tabs = [const WhoAmI(), const Countries(), const Services()];
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> getPassword() async {
    return await _secureStorage.read(key: 'password');
  }

  static HomeScreenViewModel getBloc(BuildContext context) =>
      BlocProvider.of(context);

  void changeSelectedIndex(int newSelectedIndex) {
    if (newSelectedIndex == selectedIndex) {
      refreshCurrentTab();
    } else {
      emit(HomeInitState());
      selectedIndex = newSelectedIndex;
      emit(ChangeNavBarState());
    }
  }

  void refreshCurrentTab() {
    switch (selectedIndex) {
      case 0:
        getProfile();
        break;
      case 1:
        getCountries();
        break;
      case 2:
        getServices();
        getPopularServices();
        break;
      default:
        break;
    }
  }

  Future<void> getCountries({int page = 1}) async {
    emit(CountriesLoadingState());
    var either = await getCountriesUseCase.invoke(page);
    either.fold(
      (failure) => emit(CountriesErrorState(errorMessage: 'Try again Later')),
      (countriesData) =>
          emit(CountriesSuccessState(countriesData: countriesData)),
    );
  }

  Future<void> getServices() async {
    emit(ServicesLoadingState());
    var either = await getServicesUseCase.invoke();
    either.fold(
      (failure) => emit(ServicesErrorState(errorMessage: 'Try again Later')),
      (servicesData) {
        final currentState = state;
        if (currentState is PopularServicesSuccessState) {
          emit(CombinedServicesSuccessState(
            servicesData: servicesData,
            popularServicesData: currentState.popularServicesData,
          ));
        } else {
          emit(ServicesSuccessState(servicesData: servicesData));
        }
      },
    );
  }

  Future<void> getPopularServices() async {
    emit(PopularServicesLoadingState());
    var either = await getPopularServicesUseCase.invoke();
    either.fold(
      (failure) =>
          emit(PopularServicesErrorState(errorMessage: 'Try again Later')),
      (popularServicesData) {
        final currentState = state;
        if (currentState is ServicesSuccessState) {
          emit(CombinedServicesSuccessState(
            servicesData: currentState.servicesData,
            popularServicesData: popularServicesData,
          ));
        } else {
          emit(PopularServicesSuccessState(
            popularServicesData: popularServicesData,
          ));
        }
      },
    );
  }

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    var either = await getProfileUseCase.invoke();
    either.fold(
      (failure) => emit(ProfileErrorState(errorMessage: 'Try again Later')),
      (profileData) async {
        String password = await getPassword() ?? '';
        emit(ProfileSuccessState(profileData: profileData, password: password));
      },
    );
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'isLoggedIn');
  }
}
