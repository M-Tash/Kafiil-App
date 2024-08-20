import 'dart:io';

import 'package:dartz/dartz.dart';

import '../entities/RegisterResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failures, RegisterResponseEntity>> invoke(
    String firstName,
    String lastName,
    String about,
    List<int> tags,
    List<String> favoriteSocialMedia,
    int salary,
    String password,
    String passwordConfirmation,
    String email,
    String birthDate,
    int gender,
    int type,
    File avatar,
  ) {
    return authRepository.register(
      firstName,
      lastName,
      about,
      tags,
      favoriteSocialMedia,
      salary,
      password,
      passwordConfirmation,
      email,
      birthDate,
      gender,
      type,
      avatar,
    );
  }
}
