import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:nutria/src/screen/models/foods_list_data.dart';
import 'package:nutria/src/service/food_dao.dart';
import 'package:nutria/src/utilities/format.dart';
import 'package:nutria/src/widgets/custom_modal_sheet.dart';
import 'package:nutria/src/widgets/panel_handle.dart';

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
                    foodsListData: foodData,
                    animation: animation,
                    animationController: animationController!,
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
      {Key? key, this.foodsListData, this.animationController, this.animation})
      : super(key: key);

  final FoodData? foodsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final foodDao = FoodDao();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 200,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: HexColor(foodsListData!.endColor!)
                              .withOpacity(0.6),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                    gradient: LinearGradient(
                      colors: <HexColor>[
                        HexColor(foodsListData!.startColor!),
                        HexColor(foodsListData!.endColor!),
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
                    child: Row(
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
                                  foodsListData!.titleTxt!,
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
                              foodsListData!.kacl.toString(),
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
                                color: HexColor(foodsListData!.endColor!),
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
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100),
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
                                      SizedBox(height: 15),
                                      PanelHandle(),
                                      SizedBox(height: 15),
                                      Container(
                                        child: Text('Contents'),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
