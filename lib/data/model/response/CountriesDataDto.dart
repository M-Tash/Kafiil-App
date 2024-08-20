import 'package:kafiil_test/domain/entities/CountriesDataEntity.dart';

class CountriesDataDto extends CountriesDataEntity {
  CountriesDataDto({
    super.status,
    super.success,
    super.data,
    super.pagination,
  });

  CountriesDataDto.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataDto.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? PaginationDto.fromJson(json['pagination'])
        : null;
  }
}

class PaginationDto extends PaginationEntity {
  PaginationDto({
    super.count,
    super.total,
    super.perPage,
    super.currentPage,
    super.totalPages,
    super.links,
  });

  PaginationDto.fromJson(dynamic json) {
    count = json['count'];
    total = json['total'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    links = json['links'] != null ? LinksDto.fromJson(json['links']) : null;
  }
}

class LinksDto extends LinksEntity {
  LinksDto({
    super.next,
  });

  LinksDto.fromJson(dynamic json) {
    next = json['next'];
  }
}

class DataDto extends DataEntity {
  DataDto({
    super.id,
    super.countryCode,
    super.name,
    super.capital,
  });

  DataDto.fromJson(dynamic json) {
    id = json['id'];
    countryCode = json['country_code'];
    name = json['name'];
    capital = json['capital'];
  }
}
