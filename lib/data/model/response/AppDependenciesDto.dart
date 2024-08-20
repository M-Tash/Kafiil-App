import 'package:kafiil_test/domain/entities/AppDependenciesEntity.dart';

class AppDependenciesDto extends AppDependenciesEntity {
  AppDependenciesDto({
    super.status,
    super.success,
    super.data,
  });

  AppDependenciesDto.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? DataDto.fromJson(json['data']) : null;
  }


}

class DataDto extends DataEntity {
  DataDto({
    super.types,
    super.tags,
    super.socialMedia,
  });

  DataDto.fromJson(dynamic json) {
    if (json['types'] != null) {
      types = [];
      json['types'].forEach((v) {
        types?.add(TypesDto.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(TagsDto.fromJson(v));
      });
    }
    if (json['social_media'] != null) {
      socialMedia = [];
      json['social_media'].forEach((v) {
        socialMedia?.add(SocialMediaDto.fromJson(v));
      });
    }
  }
}

class SocialMediaDto extends SocialMediaEntity {
  SocialMediaDto({
    super.value,
    super.label,
  });

  SocialMediaDto.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
}

class TagsDto extends TagsEntity {
  TagsDto({
    super.value,
    super.label,
  });

  TagsDto.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
}

class TypesDto extends TypesEntity {
  TypesDto({
    super.value,
    super.label,
  });

  TypesDto.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
}
