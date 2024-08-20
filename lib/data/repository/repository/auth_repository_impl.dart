import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kafiil_test/domain/entities/LoginResponseEntity.dart';
import 'package:kafiil_test/domain/entities/RegisterResponseEntity.dart';
import 'package:kafiil_test/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:kafiil_test/domain/repository/repository/auth_repository.dart';

import '../../../domain/entities/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
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
  ) {
    return remoteDataSource.register(
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
