import '../../../domain/entities/ProfileDataEntity.dart';

class ProfileDataDto extends ProfileDataEntity {
  ProfileDataDto({
    super.status,
    super.success,
    super.data,
  });

  ProfileDataDto.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? DataDto.fromJson(json['data']) : null;
  }
}

class DataDto extends DataEntity {
  DataDto({
    super.id,
    super.firstName,
    super.lastName,
    super.about,
    super.tags,
    super.favoriteSocialMedia,
    super.salary,
    super.email,
    super.birthDate,
    super.gender,
    super.type,
    super.avatar,
  });

  DataDto.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    about = json['about'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(TagsDto.fromJson(v));
      });
    }
    favoriteSocialMedia = json['favorite_social_media'] != null
        ? json['favorite_social_media'].cast<String>()
        : [];
    salary = json['salary'];
    email = json['email'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    type = json['type'] != null ? TypeDto.fromJson(json['type']) : null;
    avatar = json['avatar'];
  }
}

class TypeDto extends TypeEntity {
  TypeDto({
    super.code,
    super.name,
    super.niceName,
  });

  TypeDto.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    niceName = json['nice_name'];
  }
}

class TagsDto extends TagsEntity {
  TagsDto({
    super.id,
    super.name,
  });

  TagsDto.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
