import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/CountriesDataEntity.dart';
import 'package:kafiil_test/domain/repository/repository/home_repository.dart';

import '../entities/failures.dart';

class GetCountriesUseCase {
  final HomeRepository homeRepository;

  GetCountriesUseCase({required this.homeRepository});

  Future<Either<Failures, CountriesDataEntity>> invoke(int page) {
    return homeRepository.getCountries(page);
  }
}
