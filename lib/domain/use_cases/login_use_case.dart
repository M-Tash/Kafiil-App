import 'package:dartz/dartz.dart';

import '../entities/LoginResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failures, LoginResponseEntity>> invoke(
      String email, String password) {
    return authRepository.login(email, password);
  }
}
