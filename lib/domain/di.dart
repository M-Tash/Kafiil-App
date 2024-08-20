import 'package:kafiil_test/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:kafiil_test/domain/repository/data_source/home_remote_data_source.dart';
import 'package:kafiil_test/domain/repository/repository/auth_repository.dart';
import 'package:kafiil_test/domain/repository/repository/home_repository.dart';
import 'package:kafiil_test/domain/use_cases/get_app_dependencies_use_case.dart';
import 'package:kafiil_test/domain/use_cases/get_countries_use_case.dart';
import 'package:kafiil_test/domain/use_cases/get_popular_services_use_case.dart';
import 'package:kafiil_test/domain/use_cases/get_profile_use_case.dart';
import 'package:kafiil_test/domain/use_cases/get_services_use_case.dart';
import 'package:kafiil_test/domain/use_cases/login_use_case.dart';
import 'package:kafiil_test/domain/use_cases/register_use_case.dart';

import '../data/api/ApiManager.dart';
import '../data/repository/data_source/auth_remote_data_source_impl.dart';
import '../data/repository/data_source/home_remote_data_source_impl.dart';
import '../data/repository/repository/auth_repository_impl.dart';
import '../data/repository/repository/home_repository_impl.dart';

RegisterUseCase injectRegisterUseCase() {
  return RegisterUseCase(authRepository: injectAuthRepository());
}

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(authRepository: injectAuthRepository());
}

GetProfileUseCase injectGetProfileUseCase() {
  return GetProfileUseCase(homeRepository: injectHomeRepository());
}

GetCountriesUseCase injectGetCountriesUseCase() {
  return GetCountriesUseCase(homeRepository: injectHomeRepository());
}

GetServicesUseCase injectGetServicesUseCase() {
  return GetServicesUseCase(homeRepository: injectHomeRepository());
}

GetPopularServicesUseCase injectPopularServicesUseCase() {
  return GetPopularServicesUseCase(homeRepository: injectHomeRepository());
}

GetAppDependenciesUseCase injectAppDependenciesUseCase() {
  return GetAppDependenciesUseCase(homeRepository: injectHomeRepository());
}

HomeRepository injectHomeRepository() {
  return HomeRepositoryImpl(remoteDataSource: injectHomeRemoteDataSource());
}

HomeRemoteDataSource injectHomeRemoteDataSource() {
  return HomeRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(remoteDataSource: injectAuthRemoteDataSource());
}

AuthRemoteDataSource injectAuthRemoteDataSource() {
  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
