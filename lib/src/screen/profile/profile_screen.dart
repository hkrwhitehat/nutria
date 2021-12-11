import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/src/screen/login/create_account_page.dart';
import 'package:nutria/src/screen/ui_view/profile_view.dart';
import 'package:nutria/src/screen/ui_view/user_info_view.dart';
import 'package:nutria/src/screen/ui_view/running_view.dart';
import 'package:nutria/src/screen/ui_view/title_view.dart';
import 'package:nutria/src/service/diary_provider.dart';
import 'package:nutria/src/utilities/format.dart';
import 'package:nutria/src/widgets/custom_modal_sheet.dart';
import 'package:nutria/src/widgets/panel_handle.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../fitness_app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isFirst = true;
  String enteredAmount = '';
  String status = '';
  String bmi = '';

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
    const int count = 5;

    listViews.add(
      ProfileView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Your Info',
        subTxt: 'Edit',
        onTap: () {
          final TextEditingController _heightController =
              TextEditingController();
          final FocusNode _heightFocusNode = FocusNode();
          final TextEditingController _weightController =
              TextEditingController();
          final FocusNode _weightFocusNode = FocusNode();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))
              ),
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
                              'Edit Your Info',
                              textAlign: TextAlign.start,
                              style: FitnessAppTheme.title,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Consumer<DiaryProvider>(
                                builder: (context, notifier, _) {
                              _weightController.text =
                                  notifier.userData!.weight.toString();
                              _heightController.text =
                                  notifier.userData!.height.toString();
                              return Column(
                                children: [
                                  ///Weight
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Weight : ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      _buildEnterAmount(
                                          _weightController,
                                          _weightFocusNode,
                                          'kg',
                                          notifier.userData!.weight.toString()),
                                    ],
                                  ),

                                  ///Height
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Height : ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      _buildEnterAmount(
                                          _heightController,
                                          _heightFocusNode,
                                          'cm',
                                          notifier.userData!.height.toString()),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  ///Update Button
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
                                                  color: FitnessAppTheme
                                                      .nearlyBlack
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
                                          double calc = double.parse(
                                                  _weightController.text) /
                                              pow(
                                                  double.parse(_heightController
                                                          .text) /
                                                      100,
                                                  2);
                                          setState(() {
                                            bmi = calc.toStringAsFixed(1);
                                            status = bmiCalculator(
                                                double.parse(
                                                    _heightController.text),
                                                double.parse(
                                                    _weightController.text));
                                          });
                                          print(
                                              '### name: ${notifier.userData!.name}');
                                          print(
                                              '### age: ${notifier.userData!.age}');
                                          print(
                                              '### sex: ${notifier.userData!.sex}');
                                          print(
                                              '### bmi: ${notifier.userData!.bmi}');
                                          print(
                                              '### weight: ${_weightController.text}');
                                          print(
                                              '### height: ${_heightController.text}');

                                          await Provider.of<DiaryProvider>(
                                                  context,
                                                  listen: false)
                                              .addUser(
                                                  age: notifier.userData!.age!,
                                                  gender: notifier.userData!.sex!,
                                                  height: double.parse(
                                                      _heightController.text),
                                                  weight: double.parse(
                                                      _weightController.text),
                                                  bmi: double.parse(bmi),
                                                  status: status)
                                              .whenComplete(() async {
                                            await Provider.of<DiaryProvider>(
                                                    context,
                                                    listen: false)
                                                .getUserData();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              });
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      UserInfoView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Reference',
        subTxt: 'View',
        onTap: () {
          CustomModalSheet.show(
              context: context,
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                            'References',
                            textAlign: TextAlign.start,
                            style: FitnessAppTheme.title,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Flexible(
                        child: SingleChildScrollView(
                          child: Text(
                              '1.	Pollard CM, Pulker CE, Meng X, Kerr DA and Scott JA. Who uses the internet as a source of nutrition and dietary information? An Australian population perspective Journal of medical Internet research. 17(8), e209 (2015).'
                              '\n\n2.	Schumer H, Amadi C and Joshi A. Evaluating the dietary and nutritional apps in the google play store. Healthcare informatics research. 24(1), 38-45 (2018).'
                              '\n\n3.	Hamzah MR, Mohammad EMW, Abdullah MY and Ayub SH. Scenario on healthinformation seeking in Malaysia: A Systematic review. Journal of Human Development and Communication. 4  pp. 7-20 (2015).'
                              '\n\n4.	Archundia HM and Chan CB. Narrative review of new methods for assessing food and energy intake. Nutrients. 10(8), 1064 (2018).'
                              '\n\n5.	Ferrara G, Kim J, Lin S, Hua J and Seto E. A focused review of smartphone diet-tracking apps: usability, functionality, coherence with behavior change theory, and comparative validity of nutrient intake and energy estimates. JMIR mHealth and uHealth. 7(5) (2019).'
                              '\n\n6.	Holzmann SL, Pröll K, Hauner H, Holzapfel C. Nutrition apps: Quality and limitations. An explorative investigation on the basis of selected apps. Ernaehrungs Umsch. 64, 80-9 (2017).'
                              '\n\n7.	Gabrielli S, Dianti M, Maimone R, Betta M, Filippi L, Ghezzi M, Forti S. Design of a mobile app for nutrition education (TreC-LifeStyle) and formative evaluation with families of overweight children. JMIR mHealth and uHealth. 5(4), e7080 (2017 Apr 13).'
                              '\n\n8.	Wang RY, Strong DM. Beyond accuracy: What data quality means to data consumers. Journal of management information systems. 12(4), 5-33 (1996).'
                              '\n\n9.	English LP. Information quality applied: Best practices for improving business information, processes and systems. Wiley Publishing, (2009).'
                              '\n\n10.	Liaw ST, Rahimi A, Ray P, Taggart J, Dennis S, de Lusignan S, Jalaludin B, Yeo AE, Talaei-Khoei A. Towards an ontology for data quality in integrated chronic disease management: a realist review of the literature. International Journal of Medical Informatics. 82(1),10-24 (2013).'
                              '\n\n11.	Boyer, C., Appel, R.D., Ball, M.J, Van Bemmel, J.H., Bergmans, J.P., Carpentier, M., Hochstrasser D., Lindberg, D., Miller, R., Peterschmitt, J.C, Safran, C.: Health on the net\'s 20 years of transparent and reliable health '),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ));
        },
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 3, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // listViews.add(
    //   RunningView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve: const Interval((1 / count) * 2, 1.0,
    //             curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Your program',
    //     subTxt: 'Details',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    //
    // listViews.add(
    //   WorkoutView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    //
    // listViews.add(
    //   RunningView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    //
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Area of focus',
    //     subTxt: 'more',
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    //
    // listViews.add(
    //   AreaListView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController!,
    //             curve: Interval((1 / count) * 5, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController!,
    //   ),
    // );
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
                                child: Text(
                                  'Profile',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
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

  Container _buildEnterAmount(TextEditingController _amountController,
      FocusNode _amountFocusNode, String unit, String initialValue) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: TextField(
              controller: _amountController,
              focusNode: _amountFocusNode,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
                labelStyle: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  letterSpacing: -0.2,
                  color: FitnessAppTheme.darkText,
                ),
                hintStyle: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  letterSpacing: -0.2,
                  color: FitnessAppTheme.darkText,
                ),
              ),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 26,
                letterSpacing: -0.2,
                color: FitnessAppTheme.darkText,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                String newValue = value.replaceAll(',', '').replaceAll('.', '');
                if (value.isEmpty || newValue == '00') {
                  _amountController.clear();
                  isFirst = true;
                  enteredAmount = newValue;

                  setState(() {});
                  return;
                }
                double value1 = double.parse(newValue);
                print('value1 : $value1');
                // print('value1 : ${value1}');
                enteredAmount = value1.toString();

                if (!isFirst) value1 = value1 * 100;
                value = NumberFormat.currency(customPattern: '###,###.##')
                    .format(value1 / 100);
                _amountController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(offset: value.length),
                );
                setState(() {
                  print('_amountController.text : ${_amountController.text}');
                  // print('_amountController.text : ${_amountController.text}');
                  // amountValidation();
                });
              },
              keyboardType: const TextInputType.numberWithOptions(),
            ),
          ),
          Text(
            unit,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              letterSpacing: -0.2,
              color: FitnessAppTheme.nearlyDarkBlue,
            ),
          )
        ],
      ),
    );
  }
}
