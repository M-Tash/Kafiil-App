import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';
import 'package:kafiil_test/domain/entities/CountriesDataEntity.dart';
import 'package:kafiil_test/domain/entities/ProfileDataEntity.dart';
import 'package:kafiil_test/domain/entities/ServicesDataEntity.dart';

import '../../entities/failures.dart';

abstract class HomeRepository {
  Future<Either<Failures, ProfileDataEntity>> getProfile();

  Future<Either<Failures, CountriesDataEntity>> getCountries(int page);

  Future<Either<Failures, ServicesDataEntity>> getServices();

  Future<Either<Failures, ServicesDataEntity>> getPopularServices();

  Future<Either<Failures, AppDependenciesEntity>> getAppDependencies();
}
