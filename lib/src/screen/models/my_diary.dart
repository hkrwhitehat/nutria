import 'package:json_annotation/json_annotation.dart';

part 'my_diary.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class DiaryData {
  DiaryData({this.diaryData});

  List<MyDiary>? diaryData;

  factory DiaryData.fromJson(Map<String, dynamic> json) => _$DiaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$DiaryDataToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class MyDiary {
  MyDiary(
      {this.uid,
      this.name,
      this.date,
      this.lastDrink,
      this.waterConsume,
      this.recommendedWater,
      this.totalCal,
      this.remainingCal,
      this.mealList});

  String? uid;
  String? name;
  String? date;
  String? lastDrink;
  int? waterConsume;
  int? recommendedWater;
  int? totalCal;
  int? remainingCal;
  List<Meal>? mealList = [
    Meal(
        titleTxt: 'Breakfast',
        imagePath: 'assets/fitness_app/breakfast.png',
        startColor: '#FA7D82',
        endColor: '#FFB295'),
    Meal(
        titleTxt: 'Lunch',
        imagePath: 'assets/fitness_app/lunch.png',
        startColor: '#738AE6',
        endColor: '#5C5EDD'),
    Meal(
        titleTxt: 'Snack',
        imagePath: 'assets/fitness_app/snack.png',
        startColor: '#FE95B6',
        endColor: '#FF5287'),
    Meal(
        titleTxt: 'Dinner',
        imagePath: 'assets/fitness_app/dinner.png',
        startColor: '#6F72CA',
        endColor: '#1E1466')
  ];

  factory MyDiary.fromJson(Map<String, dynamic> json) =>
      _$MyDiaryFromJson(json);

  Map<String, dynamic> toJson() => _$MyDiaryToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Meal {
  String? titleTxt;
  String? imagePath;
  List<Food>? foodList;
  int? totalCal;
  int? recommendedCal;
  String? startColor;
  String? endColor;

  Meal(
      {this.titleTxt,
      this.imagePath,
      this.foodList,
      this.totalCal,
      this.recommendedCal,
      this.startColor,
      this.endColor});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Breakfast {
  String titleTxt;
  String imagePath;
  List<Food>? foodList;
  int? totalCal;
  int? recommendedCal;
  String startColor;
  String endColor;

  Breakfast(
      {this.titleTxt = 'Breakfast',
      this.imagePath = 'assets/fitness_app/breakfast.png',
      this.foodList,
      this.totalCal,
      this.recommendedCal,
      this.startColor = '#FA7D82',
      this.endColor = '#FFB295'});

  factory Breakfast.fromJson(Map<String, dynamic> json) =>
      _$BreakfastFromJson(json);

  Map<String, dynamic> toJson() => _$BreakfastToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Lunch {
  String titleTxt;
  String imagePath;
  List<Food>? foodList;
  int? totalCal;
  int? recommendedCal;
  String startColor;
  String endColor;

  Lunch(
      {this.titleTxt = 'Lunch',
      this.imagePath = 'assets/fitness_app/lunch.png',
      this.foodList,
      this.totalCal,
      this.recommendedCal,
      this.startColor = '#738AE6',
      this.endColor = '#5C5EDD'});

  factory Lunch.fromJson(Map<String, dynamic> json) => _$LunchFromJson(json);

  Map<String, dynamic> toJson() => _$LunchToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Snack {
  String titleTxt;
  String imagePath;
  List<Food>? foodList;
  int? totalCal;
  int? recommendedCal;
  String startColor;
  String endColor;

  Snack(
      {this.titleTxt = 'Snack',
      this.imagePath = 'assets/fitness_app/snack.png',
      this.foodList,
      this.totalCal,
      this.recommendedCal,
      this.startColor = '#FE95B6',
      this.endColor = '#FF5287'});

  factory Snack.fromJson(Map<String, dynamic> json) => _$SnackFromJson(json);

  Map<String, dynamic> toJson() => _$SnackToJson(this);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Dinner {
  String titleTxt;
  String imagePath;
  List<Food>? foodList;
  int? totalCal;
  int? recommendedCal;
  String startColor;
  String endColor;

  Dinner(
      {this.titleTxt = 'Dinner',
      this.imagePath = 'assets/fitness_app/dinner.png',
      this.foodList,
      this.totalCal,
      this.recommendedCal,
      this.startColor = '#6F72CA',
      this.endColor = '#1E1466'});

  factory Dinner.fromJson(Map<String, dynamic> json) => _$DinnerFromJson(json);

  Map<String, dynamic> toJson() => _$DinnerToJson(this);
}

@JsonSerializable(anyMap: true)
class Food {
  String? name;
  int? kcal;

  Food({this.name, this.kcal});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
