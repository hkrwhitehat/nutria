import 'package:nutria/src/screen/models/foods_list_data.dart';
import 'package:nutria/src/screen/my_diary/water_view.dart';
import 'package:nutria/src/screen/ui_view/body_measurement.dart';
import 'package:nutria/src/screen/ui_view/glass_view.dart';
import 'package:nutria/src/screen/ui_view/mediterranean_diet_view.dart';
import 'package:nutria/src/screen/ui_view/title_view.dart';
import 'package:nutria/src/service/admin_provider.dart';
import 'package:nutria/src/service/food_dao.dart';
import 'package:nutria/src/utilities/format.dart';
import 'package:nutria/src/widgets/custom_text_field.dart';
import 'package:nutria/src/widgets/panel_handle.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../fitness_app_theme.dart';
import 'package:flutter/material.dart';

import 'foods_list_view.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Mediterranean diet',
    //     subTxt: 'Details',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );

    listViews.add(
      FoodsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 1, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Food List',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22 + 6 - 6 * topBarOpacity,
                                        letterSpacing: 1.2,
                                        color: FitnessAppTheme.darkerText,
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    Consumer<AdminProvider>(
                                        builder: (context, notifier, _) {
                                      if (notifier.isAdmin) {
                                        return GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FitnessAppTheme.nearlyWhite,
                                              shape: BoxShape.circle,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: FitnessAppTheme
                                                        .nearlyBlack
                                                        .withOpacity(0.4),
                                                    offset:
                                                        const Offset(8.0, 8.0),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(6.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            buildAddBottomSheet(context);
                                          },
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Future<dynamic> buildAddBottomSheet(BuildContext context) {
    TextEditingController foodNameController = TextEditingController();
    FocusNode foodNameFocusNode = FocusNode();
    TextEditingController foodCalorieController = TextEditingController();
    FocusNode foodCalorieFocusNode = FocusNode();
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
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
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
                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                              CustomTextField(
                                controller: foodCalorieController,
                                focusNode: foodCalorieFocusNode,
                                inputType: TextInputType.number,
                                unit: 'kcal',
                              ),
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
                                  var uuid = Uuid();
                                  String key = uuid.v1();
                                  print('### key: $key');
                                  print('### name: ${foodNameController.text}');
                                  print(
                                      '### calorie: ${foodCalorieController.text}');
                                  await foodDao.addFood(
                                      key: key,
                                      data: FoodData(
                                          key: key,
                                          foodName: foodNameController.text,
                                          endColor: '#FFB295',
                                          kacl: int.parse(
                                              foodCalorieController.text),
                                          startColor: '#FA7D82'));
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
}
