class AppDependenciesEntity {
  AppDependenciesEntity({
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
    this.types,
    this.tags,
    this.socialMedia,
  });

  List<TypesEntity>? types;
  List<TagsEntity>? tags;
  List<SocialMediaEntity>? socialMedia;
}

class SocialMediaEntity {
  SocialMediaEntity({
    this.value,
    this.label,
  });

  String? value;
  String? label;
}

class TagsEntity {
  TagsEntity({
    this.value,
    this.label,
  });

  int? value;
  String? label;
}

class TypesEntity {
  TypesEntity({
    this.value,
    this.label,
  });

  int? value;
  String? label;
}
