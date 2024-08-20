import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../entities/LoginResponseEntity.dart';
import '../../entities/RegisterResponseEntity.dart';
import '../../entities/failures.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password);

  Future<Either<Failures, RegisterResponseEntity>> register(
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
  );
}
