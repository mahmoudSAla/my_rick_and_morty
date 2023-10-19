class BaseResponse<T> {
  int? code;
  String? message;
  T? data;
  Meta? meta;
  Info? info ; 

  BaseResponse({
    this.code,
    this.message,
    this.data,
    this.meta,
    this.info
  });

  factory BaseResponse.fromJson(Map<String, dynamic> ?json) {
    return BaseResponse(
      code: json?['code'],
      message: json?['message'],
      data: json?['results'],
      meta: (json?['data'] != null && json?['data'] is Map && json?['data']['meta'] != null) ? Meta.fromJson(json?['data']['meta']) : null,
      info: Info.fromJson(json?['info'])
    );
  }

  copyWith({
    int? code,
    String? message,
    T? data,
    Meta? meta,
    Info? info , 
  }) {
    return BaseResponse(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
      meta: meta ?? this.meta,
      info:  info ?? this.info
    );
  }
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}



class Info {
  int? count;
  int? pages;
  String? next;
  String? prev;

  Info({this.count, this.pages, this.next, this.prev});

   factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'] , 
      next:  json['next'] , 
      pages: json['pages'] , 
      prev: json['prev']
    ) ; 
  }

}
