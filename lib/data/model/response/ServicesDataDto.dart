import 'package:kafiil_test/domain/entities/ServicesDataEntity.dart';

class ServicesDataDto extends ServicesDataEntity {
  ServicesDataDto({
    super.status,
    super.success,
    super.data,
  });

  ServicesDataDto.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceDataDto.fromJson(v));
      });
    }
  }
}

class ServiceDataDto extends ServiceDataEntity {
  ServiceDataDto({
    super.id,
    super.mainImage,
    super.price,
    super.discount,
    super.priceAfterDiscount,
    super.title,
    super.averageRating,
    super.completedSalesCount,
    super.recommended,
  });

  ServiceDataDto.fromJson(dynamic json) {
    id = json['id'];
    mainImage = json['main_image'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    averageRating = json['average_rating'];
    completedSalesCount = json['completed_sales_count'];
    recommended = json['recommended'];
  }
}
