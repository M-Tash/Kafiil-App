import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';
import 'package:kafiil_test/domain/entities/CountriesDataEntity.dart';
import 'package:kafiil_test/domain/entities/ProfileDataEntity.dart';
import 'package:kafiil_test/domain/entities/ServicesDataEntity.dart';
import 'package:kafiil_test/domain/repository/data_source/home_remote_data_source.dart';

import '../../../domain/entities/failures.dart';
import '../../api/ApiManager.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, AppDependenciesEntity>> getAppDependencies() async {
    var either = await apiManager.getAppDependencies();
    return either.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, CountriesDataEntity>> getCountries(int page) async {
    var either = await apiManager.getCountries(page: page);
    return either.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, ServicesDataEntity>> getPopularServices() async {
    var either = await apiManager.getPopularServices();
    return either.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, ProfileDataEntity>> getProfile() async {
    var either = await apiManager.getProfile();
    return either.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, ServicesDataEntity>> getServices() async {
    var either = await apiManager.getServices();
    return either.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }
}
