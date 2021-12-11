import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  UserData(
      {this.uid,
      this.name,
      this.sex,
      this.age,
      this.height,
      this.weight,
      this.bmi,
      this.lifestyle});

  String? uid;
  String? name;
  String? sex;
  int? age;
  double? height;
  double? weight;
  double? bmi;
  String? lifestyle;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
