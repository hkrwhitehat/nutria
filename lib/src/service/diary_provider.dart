import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutria/src/screen/models/my_diary.dart';
import 'package:nutria/src/screen/models/user_data.dart';

import 'package:intl/intl.dart';

class DiaryProvider extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference diary = FirebaseFirestore.instance.collection('dairy');

  Future<void> addUser() async {
    return users
        .doc(user!.uid)
        .set(UserData(
                uid: user!.uid,
                name: user!.displayName,
                sex: 'Male',
                height: 162,
                weight: 70,
                bmi: 26.7,
                activity: 'Active')
            .toJson())
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> addDiary() async {
    ///todo - recommended calories based on activity
    return diary
        .doc(user!.uid)
        .collection(DateFormat('ddMMyyyy').format(DateTime.now()))
        .doc(user!.uid)
        .set(MyDiary(
            uid: user!.uid,
            name: user!.displayName,
            date: DateTime.now().toString(),
            lastDrink: '-',
            waterConsume: 0,
            recommendedWater: 3500,
            totalCal: 0,
            remainingCal: 3200,
            mealList: [
              Meal(
                  foodList: [],
                  totalCal: 0,
                  recommendedCal: 800,
                  titleTxt: 'Breakfast',
                  imagePath: 'assets/fitness_app/breakfast.png',
                  startColor: '#FA7D82',
                  endColor: '#FFB295'),
              Meal(
                  foodList: [],
                  totalCal: 0,
                  recommendedCal: 800,
                  titleTxt: 'Lunch',
                  imagePath: 'assets/fitness_app/lunch.png',
                  startColor: '#738AE6',
                  endColor: '#5C5EDD'),
              Meal(
                  foodList: [],
                  totalCal: 0,
                  recommendedCal: 800,
                  titleTxt: 'Snack',
                  imagePath: 'assets/fitness_app/snack.png',
                  startColor: '#FE95B6',
                  endColor: '#FF5287'),
              Meal(
                  foodList: [],
                  totalCal: 0,
                  recommendedCal: 800,
                  titleTxt: 'Dinner',
                  imagePath: 'assets/fitness_app/dinner.png',
                  startColor: '#6F72CA',
                  endColor: '#1E1466')
            ]).toJson())
        .then((value) {
      print('Diary Added');
      getMyDiary(DateTime.now().toString());
    }).catchError((error) => print('Failed to add diary: $error'));
  }

  late UserData _userData;

  UserData get userData => _userData;

  void setUserData(UserData data) {
    _userData = data;
    notifyListeners();
  }

  void getUserData() {
    users.doc(user!.uid).get().then((value) {
      print(value.data());
      setUserData(UserData.fromJson(value.data() as Map<String, dynamic>));
    }).catchError((error) => print('Failed to get user: $error'));
  }

  MyDiary? _myDiaryData;

  MyDiary? get myDiaryData => _myDiaryData;

  void setMyDiaryData(MyDiary data) {
    _myDiaryData = data;
    print('### diary setted! : ${data.date}');
    print('### diary : ${data.toJson()}');
    notifyListeners();
  }

  void getMyDiary(String date) {
    diary
        .doc(user!.uid)
        .collection(DateFormat('ddMMyyyy').format(DateTime.parse(date)))
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        addDiary();
        // notifyListeners();
      }
      setMyDiaryData(MyDiary.fromJson(value.data() as Map<String, dynamic>));
    }).catchError((error) => print('Failed to get my diary: $error'));
  }

  bool _backArrow = true;

  bool get backArrow => _backArrow;

  void setBackArrow(bool isShow) {
    _backArrow = isShow;
    notifyListeners();
  }

  Future<void> isFirst(String date) async {
    diary
        .doc(user!.uid)
        .collection(DateFormat('ddMMyyyy').format(DateTime.parse(date)))
        .get()
        .then((value) {
      print('### data : ${value.docs}');
      if (value.docs.isEmpty) {
        print('hide back button');
        setBackArrow(false);
      } else {
        print('show back button');
        setBackArrow(true);
      }
    });
  }

  void setWaterConsume(int volume) {
    diary
        .doc(user!.uid)
        .collection(DateFormat('ddMMyyyy').format(DateTime.now()))
        .doc(user!.uid)
        .update({
      'lastDrink': DateTime.now().toString(),
      'waterConsume': volume
    }).then((value) {
      print('Water consume Added');
      getMyDiary(DateTime.now().toString());
    }).catchError((error) => print('Failed to add water consume: $error'));
  }
}
