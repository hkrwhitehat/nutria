import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:nutria/src/screen/models/foods_list_data.dart';
import 'package:nutria/src/screen/models/my_diary.dart';
import 'package:nutria/src/service/admin_provider.dart';
import 'package:nutria/src/service/diary_provider.dart';
import 'package:nutria/src/service/food_dao.dart';
import 'package:nutria/src/utilities/format.dart';
import 'package:nutria/src/widgets/custom_modal_sheet.dart';
import 'package:nutria/src/widgets/custom_text_field.dart';
import 'package:nutria/src/widgets/panel_handle.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../fitness_app_theme.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class FoodsListView extends StatefulWidget {
  const FoodsListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _FoodsListViewState createState() => _FoodsListViewState();
}

class _FoodsListViewState extends State<FoodsListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final foodDao = FoodDao();
  List<FoodData> foodsListData = FoodData.foodList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: FirebaseAnimatedList(
                query: foodDao.getFoodListQuery(),
                padding: const EdgeInsets.only(bottom: 100),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map<String, dynamic> map = Map.from(snapshot.value);
                  var foodData = FoodData.fromJson(map);
                  // List<FoodData> foodList = [];
                  // foodDao.getFoodListQuery().once().then((value) {
                  //   Map<dynamic, dynamic> data = value.value;
                  //   data.forEach((key, value) {
                  //     Map<String, dynamic> map = Map.from(value);
                  //     foodList.add(FoodData.fromJson(map));
                  //   });
                  // });
                  // final int count =
                  //     foodList.length > 10 ? 10 : foodList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / 16) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return FoodsView(
                    foodData: foodData,
                    animation: animation,
                    animationController: animationController!,
                    index: index,
                  );
                },
              ),
              // child: ListView.builder(
              //   padding: const EdgeInsets.only(
              //       top: 0, bottom: 0, right: 16, left: 16),
              //   itemCount: foodsListData.length,
              //   scrollDirection: Axis.vertical,
              //   itemBuilder: (BuildContext context, int index) {
              //     final int count =
              //         foodsListData.length > 10 ? 10 : foodsListData.length;
              //     final Animation<double> animation =
              //         Tween<double>(begin: 0.0, end: 1.0).animate(
              //             CurvedAnimation(
              //                 parent: animationController!,
              //                 curve: Interval((1 / count) * index, 1.0,
              //                     curve: Curves.fastOutSlowIn)));
              //     animationController?.forward();
              //
              //     return FoodsView(
              //       foodsListData: foodsListData[index],
              //       animation: animation,
              //       animationController: animationController!,
              //     );
              //   },
              // ),
            ),
          ),
        );
      },
    );
  }
}

class FoodsView extends StatelessWidget {
  const FoodsView(
      {Key? key,
      required this.index,
      required this.foodData,
      required this.animationController,
      required this.animation})
      : super(key: key);

  final int index;
  final FoodData foodData;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final foodDao = FoodDao();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 200,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: endColor(index).withOpacity(0.6),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        startColor(index),
                        endColor(index),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(54.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 8),
                    child: Consumer<AdminProvider>(
                        builder: (context, adminNotifier, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    foodData.foodName!,
                                    style: const TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                foodData.kacl.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  'kcal',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          adminNotifier.isAdmin
                              ? Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FitnessAppTheme.nearlyWhite,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: FitnessAppTheme
                                                    .nearlyBlack
                                                    .withOpacity(0.4),
                                                offset: const Offset(8.0, 8.0),
                                                blurRadius: 8.0),
                                          ],
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.amber,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        buildEditBottomSheet(context, foodData);
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FitnessAppTheme.nearlyWhite,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: FitnessAppTheme
                                                    .nearlyBlack
                                                    .withOpacity(0.4),
                                                offset: const Offset(8.0, 8.0),
                                                blurRadius: 8.0),
                                          ],
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        final foodDao = FoodDao();
                                        await foodDao.deleteFood(foodData.key!);
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.nearlyWhite,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: FitnessAppTheme.nearlyBlack
                                          .withOpacity(0.4),
                                      offset: const Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: endColor(index),
                                  size: 24,
                                ),
                              ),
                            ),
                            onTap: () async {
                              // foodDao.saveFood(foodsListData!);
                              foodDao.getFoodListQuery().once().then((value) {
                                List<FoodData> foodList = [];
                                Map<dynamic, dynamic> data = value.value;
                                data.forEach((key, value) {
                                  Map<String, dynamic> map = Map.from(value);
                                  print(map);
                                  foodList.add(FoodData.fromJson(map));
                                });
                                print(foodList);
                              });
                              CustomModalSheet.show(
                                  context: context,
                                  child: LimitedBox(
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              topRight: Radius.circular(50))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 15),
                                          const PanelHandle(),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: const [
                                              Text(
                                                'Add food to..',
                                                textAlign: TextAlign.start,
                                                style: FitnessAppTheme.title,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Flexible(
                                            child: Consumer<DiaryProvider>(
                                                builder:
                                                    (context, notifier, _) {
                                              List<Meal> mealListData;
                                              if (notifier.myDiaryData!.uid ==
                                                  '') {
                                                notifier
                                                    .getMyDiary(DateFormat('ddMMyyyy').format(DateTime.now()))
                                                    .then((value) =>
                                                        mealListData = notifier
                                                            .myDiaryData!
                                                            .mealList!);
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else {
                                                mealListData = notifier
                                                    .myDiaryData!.mealList!;
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (context, item) {
                                                      return const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                      );
                                                    },
                                                    itemCount:
                                                        mealListData.length,
                                                    itemBuilder:
                                                        (context, idx) {
                                                      return buildMealType(
                                                          mealListData[idx],
                                                          foodData,
                                                          context);
                                                    });
                                              }
                                            }),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> buildEditBottomSheet(
      BuildContext context, FoodData foodData) {
    TextEditingController foodNameController = TextEditingController();
    FocusNode foodNameFocusNode = FocusNode();
    TextEditingController foodCalorieController = TextEditingController();
    FocusNode foodCalorieFocusNode = FocusNode();
    foodNameController.text = foodData.foodName!;
    foodCalorieController.text = foodData.kacl!.toString();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  const PanelHandle(),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Text(
                        'Edit Food',
                        textAlign: TextAlign.start,
                        style: FitnessAppTheme.title,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            child: Container(
                              height: 2,
                              decoration: const BoxDecoration(
                                color: FitnessAppTheme.background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ),

                          ///Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Name : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color:
                                  FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                              CustomTextField(
                                  controller: foodNameController,
                                  focusNode: foodNameFocusNode,
                                  inputType: TextInputType.name),
                            ],
                          ),

                          ///Age
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Calorie : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color:
                                  FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                              CustomTextField(
                                  controller: foodCalorieController,
                                  focusNode: foodCalorieFocusNode,
                                  inputType: TextInputType.number),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          ///Create Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor("#6F56E8"),
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: FitnessAppTheme.nearlyBlack
                                              .withOpacity(0.4),
                                          offset: const Offset(8.0, 8.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Icon(
                                      Icons.check,
                                      size: 30,
                                      color: FitnessAppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  final foodDao = FoodDao();
                                  print(
                                      '### name: ${foodNameController.text}');
                                  print(
                                      '### calorie: ${foodCalorieController.text}');
                                  await foodDao.updateFood(FoodData(
                                      key: foodData.key,
                                      foodName: foodNameController.text,
                                      kacl: int.parse(
                                          foodCalorieController.text)));
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
  }

  GestureDetector buildMealType(
      Meal mealListData, FoodData foodData, BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: HexColor(mealListData.endColor!).withOpacity(0.6),
                offset: const Offset(1.1, 4.0),
                blurRadius: 8.0),
          ],
          gradient: LinearGradient(
            colors: <HexColor>[
              HexColor(mealListData.startColor!),
              HexColor(mealListData.endColor!),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(54.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                mealListData.titleTxt!,
                style: const TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.2,
                  color: FitnessAppTheme.white,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(mealListData.imagePath!),
            )
          ],
        ),
      ),
      onTap: () {
        ///todo - add food to diary
        Provider.of<DiaryProvider>(context, listen: false)
            .addFoodDiary(foodData, mealListData.titleTxt!);
        Navigator.pop(context);
      },
    );
  }

  Color startColor(int index) {
    if (index % 4 == 0) {
      return const Color(0xFFFA7D82);
    } else if (index % 4 == 1) {
      return const Color(0xFF738AE6);
    } else if (index % 4 == 2) {
      return const Color(0xFFFE95B6);
    } else if (index % 4 == 3) {
      return const Color(0xFF6F72CA);
    } else {
      return const Color(0xFFFA7D82);
    }
  }

  Color endColor(int index) {
    if (index % 4 == 0) {
      return const Color(0xFFFFB295);
    } else if (index % 4 == 1) {
      return const Color(0xFF5C5EDD);
    } else if (index % 4 == 2) {
      return const Color(0xFFFF5287);
    } else if (index % 4 == 3) {
      return const Color(0xFF1E1466);
    } else {
      return const Color(0xFFFFB295);
    }
  }
}
