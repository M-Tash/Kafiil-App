class ProfileDataEntity {
  ProfileDataEntity({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  DataEntity? data;
}

class DataEntity {
  DataEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.about,
    this.tags,
    this.favoriteSocialMedia,
    this.salary,
    this.email,
    this.birthDate,
    this.gender,
    this.type,
    this.avatar,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? about;
  List<TagsEntity>? tags;
  List<String>? favoriteSocialMedia;
  int? salary;
  String? email;
  String? birthDate;
  int? gender;
  TypeEntity? type;
  String? avatar;
}

class TypeEntity {
  TypeEntity({
    this.code,
    this.name,
    this.niceName,
  });

  int? code;
  String? name;
  String? niceName;
}

class TagsEntity {
  TagsEntity({
    this.id,
    this.name,
  });

  int? id;
  String? name;
}
