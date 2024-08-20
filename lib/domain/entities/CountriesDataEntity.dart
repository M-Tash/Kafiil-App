class CountriesDataEntity {
  CountriesDataEntity({
    this.status,
    this.success,
    this.data,
    this.pagination,
  });

  int? status;
  bool? success;
  List<DataEntity>? data;
  PaginationEntity? pagination;
}

class PaginationEntity {
  PaginationEntity({
    this.count,
    this.total,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  int? count;
  int? total;
  int? perPage;
  int? currentPage;
  int? totalPages;
  LinksEntity? links;
}

class LinksEntity {
  LinksEntity({
    this.next,
  });

  String? next;
}

class DataEntity {
  DataEntity({
    this.id,
    this.countryCode,
    this.name,
    this.capital,
  });

  int? id;
  String? countryCode;
  String? name;
  String? capital;
}
