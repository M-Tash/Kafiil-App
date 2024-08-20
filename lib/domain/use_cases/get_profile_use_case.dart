import 'package:dartz/dartz.dart';

import '../entities/ProfileDataEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository.dart';

class GetProfileUseCase {
  final HomeRepository homeRepository;

  GetProfileUseCase({required this.homeRepository});

  Future<Either<Failures, ProfileDataEntity>> invoke() {
    return homeRepository.getProfile();
  }
}
