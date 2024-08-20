import 'package:dartz/dartz.dart';

import '../entities/ServicesDataEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository.dart';

class GetServicesUseCase {
  final HomeRepository homeRepository;

  GetServicesUseCase({required this.homeRepository});

  Future<Either<Failures, ServicesDataEntity>> invoke() {
    return homeRepository.getServices();
  }
}
