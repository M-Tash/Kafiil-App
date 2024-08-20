import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kafiil_test/data/api/ApiManager.dart';
import 'package:kafiil_test/domain/entities/LoginResponseEntity.dart';
import 'package:kafiil_test/domain/entities/RegisterResponseEntity.dart';
import 'package:kafiil_test/domain/repository/data_source/auth_remote_data_source.dart';

import '../../../domain/entities/failures.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String email, String password) async {
    var response = await apiManager.login(email: email, password: password);
    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
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
  ) async {
    var response = await apiManager.register(
      firstName: firstName,
      lastName: lastName,
      about: about,
      tags: tags,
      favoriteSocialMedia: favoriteSocialMedia,
      salary: salary,
      password: password,
      passwordConfirmation: passwordConfirmation,
      email: email,
      birthDate: birthDate,
      gender: gender,
      type: type,
      avatar: avatar,
    );
    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }
}
