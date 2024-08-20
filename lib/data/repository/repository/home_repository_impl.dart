import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';
import 'package:kafiil_test/domain/entities/CountriesDataEntity.dart';
import 'package:kafiil_test/domain/entities/ProfileDataEntity.dart';
import 'package:kafiil_test/domain/entities/ServicesDataEntity.dart';
import 'package:kafiil_test/domain/repository/data_source/home_remote_data_source.dart';
import 'package:kafiil_test/domain/repository/repository/home_repository.dart';

import '../../../domain/entities/failures.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, AppDependenciesEntity>> getAppDependencies() {
    return remoteDataSource.getAppDependencies();
  }

  @override
  Future<Either<Failures, CountriesDataEntity>> getCountries(int page) {
    return remoteDataSource.getCountries(page);
  }

  @override
  Future<Either<Failures, ServicesDataEntity>> getPopularServices() {
    return remoteDataSource.getPopularServices();
  }

  @override
  Future<Either<Failures, ProfileDataEntity>> getProfile() {
    return remoteDataSource.getProfile();
  }

  @override
  Future<Either<Failures, ServicesDataEntity>> getServices() {
    return remoteDataSource.getServices();
  }
}
