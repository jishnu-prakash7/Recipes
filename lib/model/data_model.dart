class DataModel {
  String dishName;
  String dishId;
  String imageUrl;

  DataModel({
    required this.dishName,
    required this.dishId,
    required this.imageUrl,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        dishName: json["dishName"],
        dishId: json["dishId"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "dishName": dishName,
        "dishId": dishId,
        "imageUrl": imageUrl,
      };
}
