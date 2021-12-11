import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutria/src/screen/models/foods_list_data.dart'
    as food_list_data;
import 'package:nutria/src/screen/models/my_diary.dart';
import 'package:nutria/src/screen/models/user_data.dart';

import 'package:intl/intl.dart';

class DiaryProvider extends ChangeNotifier {
  User? _user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference diary = FirebaseFirestore.instance.collection('diary');

  User? get user => _user;

  Future<void> setUser(User user) async {
      _user = user;
    notifyListeners();
  }

  Future<void> addUser(
      {required int age,
      required String gender,
      required double height,
      required double weight,
      required double bmi,
      required String status}) async {
    return users
        .doc(user!.email)
        .set(UserData(
                uid: user!.uid,
                name: user!.displayName,
                sex: gender,
                age: age,
                height: height,
                weight: weight,
                bmi: bmi,
                lifestyle: 'Active')
            .toJson())
        .then((value) async {
      print('User Added');
      await createDiary();
    }).catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> createDiary() async {
    ///todo - recommended calories based on activity
    ///check if diary list is empty
    ///create new diary
    ///if not, append diary

    _diaryList!.forEach((element) {
      print('before ####### ${_diaryList!.indexOf(element)}');
    });
    _diaryList!.add(MyDiary(
        uid: user!.uid,
        name: user!.displayName,
        date: DateFormat('ddMMyyyy').format(DateTime.now()).toString(),
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
        ]));
    _diaryList!.forEach((element) {
      print('after ####### ${_diaryList!.indexOf(element)}');
    });
    return diary
        .doc(user!.email)
        .set(DiaryData(diaryData: _diaryList).toJson(), SetOptions(merge: true))
        .then((value) {
      print('Diary Added');
      getMyDiary(DateFormat('ddMMyyyy').format(DateTime.now()));
    }).catchError((error) => print('Failed to add diary: $error'));
  }

  Future<void> addFoodDiary(
      food_list_data.FoodData foodData, String type) async {
    // MyDiary currentDiary = _diaryList!.firstWhere((element) {
    //   return element.date!.contains(
    //       myDiaryData!.date!);
    // }, orElse: () {
    //   return MyDiary();
    // });
    print('### mydiary ${myDiaryData!.toJson()}');

    int totalCal = _myDiaryData!.totalCal! + foodData.kacl!;
    int remainCal = _myDiaryData!.remainingCal! - foodData.kacl!;
    List<Meal> mealList = _myDiaryData!.mealList!;
    myDiaryData!.totalCal = totalCal;
    myDiaryData!.remainingCal = remainCal;
    switch (type) {
      case 'Breakfast':
        Meal breakfast = mealList[
            mealList.indexWhere((element) => element.titleTxt == 'Breakfast')];
        List<Food> foodList = breakfast.foodList!;
        foodList.add(Food(name: foodData.foodName, kcal: foodData.kacl));
        breakfast.totalCal = breakfast.totalCal! + foodData.kacl!;
        breakfast.foodList = foodList;
        myDiaryData!.mealList![0].foodList = foodList;
        break;
      case 'Lunch':
        Meal lunch = mealList[
            mealList.indexWhere((element) => element.titleTxt == 'Lunch')];
        List<Food> foodList = lunch.foodList!;
        foodList.add(Food(name: foodData.foodName, kcal: foodData.kacl));
        lunch.totalCal = lunch.totalCal! + foodData.kacl!;
        lunch.foodList = foodList;
        myDiaryData!.mealList![1].foodList = foodList;
        break;
      case 'Snack':
        Meal snack = mealList[
            mealList.indexWhere((element) => element.titleTxt == 'Snack')];
        List<Food> foodList = snack.foodList!;
        foodList.add(Food(name: foodData.foodName, kcal: foodData.kacl));
        snack.totalCal = snack.totalCal! + foodData.kacl!;
        snack.foodList = foodList;
        myDiaryData!.mealList![2].foodList = foodList;
        break;
      case 'Dinner':
        Meal dinner = mealList[
            mealList.indexWhere((element) => element.titleTxt == 'Dinner')];
        List<Food> foodList = dinner.foodList!;
        foodList.add(Food(name: foodData.foodName, kcal: foodData.kacl));
        dinner.totalCal = dinner.totalCal! + foodData.kacl!;
        dinner.foodList = foodList;
        myDiaryData!.mealList![3].foodList = foodList;
        break;
    }
    for (MyDiary currDiary in _diaryList!) {
      if (currDiary.date == myDiaryData!.date!) {
        _diaryList![_diaryList!.indexOf(currDiary)] = myDiaryData!;
        diary
            .doc(user!.email)
            .set(DiaryData(diaryData: _diaryList).toJson(),
                SetOptions(merge: true))
            .then((value) {
          print('Food Diary Added');
          getMyDiary(myDiaryData!.date!);
        }).catchError(
                (error) => print('Failed to add food into diary: $error'));
      }
    }
  }

  UserData? _userData;

  UserData? get userData => _userData;

  void setUserData(UserData data) {
    _userData = data;
    notifyListeners();
  }

  Future<bool> getUserData() {
    return users.doc(user!.email).get().then((value) {
      print('### User Data from Firebase : ${value.data()}');
      setUserData(UserData.fromJson(value.data() as Map<String, dynamic>));
      return true;
    }).catchError((error) {
      print('Failed to get user: $error');
      return false;
    });
  }

  Future<bool> checkUser(String email) async {
    bool resp = false;
    return users.doc(email).get().then((value) {
      print('check user  : ${value.exists}');
        if (value.exists) {
          print('User exist');
          return true;
        } else {
          print('User not exist');
          return false;
        }
    });
  }

  MyDiary? _myDiaryData;

  MyDiary? get myDiaryData => _myDiaryData;

  void setMyDiaryData(MyDiary data) {
    _myDiaryData = data;
    if (data.uid != 'null') {
      setCurrentDate(data.date!);
      setCurrentDay(data.date!);
    }
    print('### diary setted! : ${data.date}');
    print('### diary : ${data.toJson()}');
    notifyListeners();
  }

  List<MyDiary>? _diaryList = [];

  List<MyDiary>? get diaryList => _diaryList;

  void setDiaryList(List<MyDiary> list) {
    _diaryList = list;
    notifyListeners();
  }

  Future<void> getMyDiary(String date) async {
    await diary.doc(user!.email).get().then((value) {
      print('### ${value.data()}');
      if (value.data().toString() == "{}") {
        print('### no diary data');
        createDiary();
      } else {
        DiaryData? diaryData =
            DiaryData.fromJson(value.data() as Map<String, dynamic>);
        if(diaryData.diaryData!.isNotEmpty) {
          setDiaryList(diaryData.diaryData!);
          MyDiary? currentDiary = diaryData.diaryData!.firstWhere(
                  (element) => element.date!.contains(date),
              orElse: () => MyDiary());
          if (currentDiary.date == null) {
            print('### null diary for today');
            createDiary();
            // notifyListeners();
          } else {
            setMyDiaryData(currentDiary);
          }
        } else {
          print('### null diary');
          createDiary();
        }

      }
    }).catchError((error) => print('Failed to get my diary: $error'));
  }

  bool _backArrow = true;

  bool get backArrow => _backArrow;

  void setBackArrow(bool isShow) {
    _backArrow = isShow;
    notifyListeners();
  }

  bool _rightArrow = true;

  bool get rightArrow => _rightArrow;

  void setRightArrow(bool isShow) {
    _rightArrow = isShow;
    notifyListeners();
  }

  String? _currentDate;

  String? get currentDate => _currentDate;

  setCurrentDate(String date) {
    String day = date.substring(0, 2);
    String month = date.substring(2, 4);
    String year = date.substring(4, 8);
    date = year + month + day;

    _currentDate = DateFormat('dd MMM').format(DateTime.parse(date));
    print('### current date $currentDate');
    notifyListeners();
  }

  String? _currentDay;

  String? get currentDay => _currentDay;

  setCurrentDay(String date) {
    String day = date.substring(0, 2);
    String month = date.substring(2, 4);
    String year = date.substring(4, 8);
    date = year + month + day;

    _currentDay = DateFormat('EEEE').format(DateTime.parse(date)).toString();
    print('### current day $currentDay');
    notifyListeners();
  }

  void setWaterConsume(int volume) {
    myDiaryData!.waterConsume = volume;
    myDiaryData!.lastDrink = DateTime.now().toString();
    for (MyDiary currDiary in _diaryList!) {
      if (currDiary.date == myDiaryData!.date!) {
        _diaryList![_diaryList!.indexOf(currDiary)] = myDiaryData!;
        diary
            .doc(user!.email)
            .set(DiaryData(diaryData: _diaryList).toJson(),
                SetOptions(merge: true))
            .then((value) {
          print('Water consume Added');
          getMyDiary(myDiaryData!.date!);
        }).catchError(
                (error) => print('Failed to update water consume: $error'));
      }
    }
    // diary
    //     .doc(user!.email)
    //     .update({
    //   'lastDrink': DateTime.now().toString(),
    //   'waterConsume': volume
    // }).then((value) {
    //   print('Water consume Added');
    //   getMyDiary(DateFormat('ddMMyyyy').format(DateTime.now()));
    // }).catchError((error) => print('Failed to add water consume: $error'));
  }

  Future<void> reset() async {
    setMyDiaryData(MyDiary(uid: 'null'));
    setDiaryList([]);
    setUserData(UserData());
  }
}
