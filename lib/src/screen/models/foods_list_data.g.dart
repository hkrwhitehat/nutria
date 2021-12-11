// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foods_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FoodData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'data': instance.data,
    };

FoodData _$FoodDataFromJson(Map<String, dynamic> json) => FoodData(
      key: json['key'] as String?,
      foodName: json['foodName'] as String?,
      startColor: json['startColor'] as String?,
      endColor: json['endColor'] as String?,
      kacl: json['kacl'] as int? ?? 0,
    );

Map<String, dynamic> _$FoodDataToJson(FoodData instance) => <String, dynamic>{
      'key': instance.key,
      'foodName': instance.foodName,
      'startColor': instance.startColor,
      'endColor': instance.endColor,
      'kacl': instance.kacl,
    };
