import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kafiil_test/data/model/request/LoginRequest.dart';
import 'package:kafiil_test/data/model/response/LoginResponseDto.dart';

import '../../domain/entities/failures.dart';
import '../model/response/AppDependenciesDto.dart';
import '../model/response/CountriesDataDto.dart';
import '../model/response/ErrorResponseDto.dart';
import '../model/response/ProfileDataDto.dart';
import '../model/response/RegisterResponseDto.dart';
import '../model/response/ServicesDataDto.dart';
import 'ApiHelper.dart';

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  ApiHelper apiHelper = ApiHelper.getInstance();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<Either<Failures, LoginResponseDto>> login({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse('https://test.kafiil.com/api/test/user/login');
    final loginRequest = LoginRequest(email: email, password: password);

    var result = await apiHelper.post(
      url: url,
      body: loginRequest.toJson(),
      errorMessage: 'Failed to login. Please try again.',
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) async {
        var loginResponse = LoginResponseDto.fromJson(jsonResponse);
        await saveToken(loginResponse.accessToken ?? '');
        return Right(loginResponse);
      },
    );
  }

  Future<Either<Failures, ProfileDataDto>> getProfile() async {
    String token = await getToken() ?? '';
    final Uri url = Uri.parse('https://test.kafiil.com/api/test/user/who-am-i');

    var result = await apiHelper.get(
      url: url,
      errorMessage: 'Failed to fetch Profile Data. Please try again.',
      headers: {
        'Authorization': token,
      },
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(ProfileDataDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, CountriesDataDto>> getCountries(
      {int page = 1}) async {
    Uri url = Uri.parse('https://test.kafiil.com/api/test/country?page=$page');

    var result = await apiHelper.get(
      url: url,
      errorMessage: 'Failed to fetch Countries. Please try again.',
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(CountriesDataDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, ServicesDataDto>> getServices() async {
    final Uri url = Uri.parse('https://test.kafiil.com/api/test/service');

    var result = await apiHelper.get(
      url: url,
      errorMessage: 'Failed to fetch Services. Please try again.',
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(ServicesDataDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, ServicesDataDto>> getPopularServices() async {
    final Uri url =
        Uri.parse('https://test.kafiil.com/api/test/service/popular');

    var result = await apiHelper.get(
      url: url,
      errorMessage: 'Failed to fetch Popular Services. Please try again.',
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(ServicesDataDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, AppDependenciesDto>> getAppDependencies() async {
    final Uri url = Uri.parse('https://test.kafiil.com/api/test/dependencies');

    var result = await apiHelper.get(
      url: url,
      errorMessage: 'Failed to fetch App Dependencies. Please try again.',
    );

    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(AppDependenciesDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, RegisterResponseDto>> register({
    required String firstName,
    required String lastName,
    required String about,
    required List<int> tags,
    required List<String> favoriteSocialMedia,
    required int salary,
    required String password,
    required String passwordConfirmation,
    required String email,
    required String birthDate,
    required int gender,
    required int type,
    required File avatar,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!(connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi))) {
      return Left(Failures(errorMessage: 'No internet connection'));
    }

    var uri = Uri.parse("https://test.kafiil.com/api/test/user/register");

    var request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..headers['Accept-Language'] = 'en'
      ..headers['Content-Type'] = 'multipart/form-data';

    // Set request fields
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['about'] = about;
    request.fields['salary'] = salary.toString();
    request.fields['password'] = password;
    request.fields['password_confirmation'] = passwordConfirmation;
    request.fields['email'] = email;
    request.fields['birth_date'] = birthDate;
    request.fields['gender'] = gender.toString();
    request.fields['type'] = type.toString();

    tags.asMap().forEach((index, tag) {
      request.fields['tags[$index]'] = tag.toString();
    });

    favoriteSocialMedia.asMap().forEach((index, social) {
      request.fields['favorite_social_media[$index]'] = social;
    });

    var fileStream = http.ByteStream(avatar.openRead());
    var length = await avatar.length();
    var multipartFile = http.MultipartFile(
      'avatar',
      fileStream,
      length,
      filename: avatar.path.split('/').last,
    );
    request.files.add(multipartFile);

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (responseBody.isNotEmpty) {
          var jsonResponse = json.decode(responseBody);
          return Right(RegisterResponseDto.fromJson(jsonResponse));
        } else {
          return Left(Failures(errorMessage: 'Error Try again later'));
        }
      } else {
        if (responseBody.isNotEmpty) {
          var jsonResponse = json.decode(responseBody);
          ErrorResponseDto errorResponse =
              ErrorResponseDto.fromJson(jsonResponse);
          return Left(
              Failures(errorMessage: errorResponse.errors.values.first.first));
        } else {
          return Left(Failures(errorMessage: 'Unexpected server response'));
        }
      }
    } catch (e) {
      return Left(Failures(errorMessage: 'Failed to connect to the server'));
    }
  }
}
