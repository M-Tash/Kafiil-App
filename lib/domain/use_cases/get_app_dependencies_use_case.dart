import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';
import 'package:kafiil_test/domain/repository/repository/home_repository.dart';

import '../entities/failures.dart';

class GetAppDependenciesUseCase {
  final HomeRepository homeRepository;

  GetAppDependenciesUseCase({required this.homeRepository});

  Future<Either<Failures, AppDependenciesEntity>> invoke() {
    return homeRepository.getAppDependencies();
  }
}
