// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryData _$DiaryDataFromJson(Map json) => DiaryData(
      diaryData: (json['diaryData'] as List<dynamic>?)
          ?.map((e) => MyDiary.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$DiaryDataToJson(DiaryData instance) => <String, dynamic>{
      'diaryData': instance.diaryData?.map((e) => e.toJson()).toList(),
    };

MyDiary _$MyDiaryFromJson(Map json) => MyDiary(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      date: json['date'] as String?,
      lastDrink: json['lastDrink'] as String?,
      waterConsume: json['waterConsume'] as int?,
      recommendedWater: json['recommendedWater'] as int?,
      totalCal: json['totalCal'] as int?,
      remainingCal: json['remainingCal'] as int?,
      mealList: (json['mealList'] as List<dynamic>?)
          ?.map((e) => Meal.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$MyDiaryToJson(MyDiary instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'date': instance.date,
      'lastDrink': instance.lastDrink,
      'waterConsume': instance.waterConsume,
      'recommendedWater': instance.recommendedWater,
      'totalCal': instance.totalCal,
      'remainingCal': instance.remainingCal,
      'mealList': instance.mealList?.map((e) => e.toJson()).toList(),
    };

Meal _$MealFromJson(Map json) => Meal(
      titleTxt: json['titleTxt'] as String?,
      imagePath: json['imagePath'] as String?,
      foodList: (json['foodList'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalCal: json['totalCal'] as int?,
      recommendedCal: json['recommendedCal'] as int?,
      startColor: json['startColor'] as String?,
      endColor: json['endColor'] as String?,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'titleTxt': instance.titleTxt,
      'imagePath': instance.imagePath,
      'foodList': instance.foodList?.map((e) => e.toJson()).toList(),
      'totalCal': instance.totalCal,
      'recommendedCal': instance.recommendedCal,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
    };

Breakfast _$BreakfastFromJson(Map json) => Breakfast(
      titleTxt: json['titleTxt'] as String? ?? 'Breakfast',
      imagePath:
          json['imagePath'] as String? ?? 'assets/fitness_app/breakfast.png',
      foodList: (json['foodList'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalCal: json['totalCal'] as int?,
      recommendedCal: json['recommendedCal'] as int?,
      startColor: json['startColor'] as String? ?? '#FA7D82',
      endColor: json['endColor'] as String? ?? '#FFB295',
    );

Map<String, dynamic> _$BreakfastToJson(Breakfast instance) => <String, dynamic>{
      'titleTxt': instance.titleTxt,
      'imagePath': instance.imagePath,
      'foodList': instance.foodList?.map((e) => e.toJson()).toList(),
      'totalCal': instance.totalCal,
      'recommendedCal': instance.recommendedCal,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
    };

Lunch _$LunchFromJson(Map json) => Lunch(
      titleTxt: json['titleTxt'] as String? ?? 'Lunch',
      imagePath: json['imagePath'] as String? ?? 'assets/fitness_app/lunch.png',
      foodList: (json['foodList'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalCal: json['totalCal'] as int?,
      recommendedCal: json['recommendedCal'] as int?,
      startColor: json['startColor'] as String? ?? '#738AE6',
      endColor: json['endColor'] as String? ?? '#5C5EDD',
    );

Map<String, dynamic> _$LunchToJson(Lunch instance) => <String, dynamic>{
      'titleTxt': instance.titleTxt,
      'imagePath': instance.imagePath,
      'foodList': instance.foodList?.map((e) => e.toJson()).toList(),
      'totalCal': instance.totalCal,
      'recommendedCal': instance.recommendedCal,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
    };

Snack _$SnackFromJson(Map json) => Snack(
      titleTxt: json['titleTxt'] as String? ?? 'Snack',
      imagePath: json['imagePath'] as String? ?? 'assets/fitness_app/snack.png',
      foodList: (json['foodList'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalCal: json['totalCal'] as int?,
      recommendedCal: json['recommendedCal'] as int?,
      startColor: json['startColor'] as String? ?? '#FE95B6',
      endColor: json['endColor'] as String? ?? '#FF5287',
    );

Map<String, dynamic> _$SnackToJson(Snack instance) => <String, dynamic>{
      'titleTxt': instance.titleTxt,
      'imagePath': instance.imagePath,
      'foodList': instance.foodList?.map((e) => e.toJson()).toList(),
      'totalCal': instance.totalCal,
      'recommendedCal': instance.recommendedCal,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
    };

Dinner _$DinnerFromJson(Map json) => Dinner(
      titleTxt: json['titleTxt'] as String? ?? 'Dinner',
      imagePath:
          json['imagePath'] as String? ?? 'assets/fitness_app/dinner.png',
      foodList: (json['foodList'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      totalCal: json['totalCal'] as int?,
      recommendedCal: json['recommendedCal'] as int?,
      startColor: json['startColor'] as String? ?? '#6F72CA',
      endColor: json['endColor'] as String? ?? '#1E1466',
    );

Map<String, dynamic> _$DinnerToJson(Dinner instance) => <String, dynamic>{
      'titleTxt': instance.titleTxt,
      'imagePath': instance.imagePath,
      'foodList': instance.foodList?.map((e) => e.toJson()).toList(),
      'totalCal': instance.totalCal,
      'recommendedCal': instance.recommendedCal,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
    };

Food _$FoodFromJson(Map json) => Food(
      name: json['name'] as String?,
      kcal: json['kcal'] as int?,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
      'kcal': instance.kcal,
    };
