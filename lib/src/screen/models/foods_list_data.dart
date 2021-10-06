import 'package:json_annotation/json_annotation.dart';

part 'foods_list_data.g.dart';

@JsonSerializable()
class Food {
  List<FoodData>? data;
  Food({this.data});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  static Food foodList = Food(data: [
    FoodData(
      titleTxt: 'Breakfast',
      kacl: 525,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    FoodData(
      titleTxt: 'Lunch',
      kacl: 602,
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    FoodData(
      titleTxt: 'Snack',
      kacl: 1300,
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    FoodData(
      titleTxt: 'Dinner',
      kacl: 89,
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ]);
}

@JsonSerializable()
class FoodData {
  FoodData({
    this.titleTxt,
    this.startColor,
    this.endColor,
    this.kacl = 0,
  });

  String? titleTxt;
  String? startColor;
  String? endColor;
  int? kacl;

  factory FoodData.fromJson(Map<String, dynamic> json) => _$FoodDataFromJson(json);
  Map<String, dynamic> toJson() => _$FoodDataToJson(this);

  static List<FoodData> foodList = <FoodData>[
    FoodData(
      titleTxt: 'Breakfast',
      kacl: 525,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    FoodData(
      titleTxt: 'Lunch',
      kacl: 602,
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    FoodData(
      titleTxt: 'Snack',
      kacl: 1300,
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    FoodData(
      titleTxt: 'Dinner',
      kacl: 89,
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
