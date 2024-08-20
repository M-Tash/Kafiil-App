class ServicesDataEntity {
  ServicesDataEntity({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  List<ServiceDataEntity>? data;
}

class ServiceDataEntity {
  ServiceDataEntity({
    this.id,
    this.mainImage,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.title,
    this.averageRating,
    this.completedSalesCount,
    this.recommended,
  });

  int? id;
  String? mainImage;
  int? price;
  dynamic discount;
  int? priceAfterDiscount;
  String? title;
  int? averageRating;
  int? completedSalesCount;
  bool? recommended;
}
