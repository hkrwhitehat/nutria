import 'package:flutter/material.dart';
import 'package:nutria/src/screen/models/user_data.dart';
import 'package:nutria/src/service/diary_provider.dart';
import 'package:provider/provider.dart';
import '../fitness_app_theme.dart';

class UserInfoView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const UserInfoView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 10, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.4),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8.0)),
                                child: SizedBox(
                                  height: 74,
                                  child: AspectRatio(
                                    aspectRatio: 1.714,
                                    child: Image.asset(
                                        "assets/fitness_app/back.png"),
                                  ),
                                ),
                              ),
                              Consumer<DiaryProvider>(
                                builder: (context, notifier, _) {
                                  if (notifier.userData == null) {
                                    notifier.getUserData();
                                  }
                                  UserData? userData = notifier.userData;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: const <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 100,
                                              right: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 120,
                                          bottom: 12,
                                          top: 12,
                                          right: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Sex: ${userData!.sex}",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                color:
                                                    FitnessAppTheme.nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              "Age: ${userData.age}",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                color:
                                                    FitnessAppTheme.nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              "Weight: ${userData.weight}kg",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                color:
                                                    FitnessAppTheme.nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              "Height: ${userData.height}cm",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                color:
                                                    FitnessAppTheme.nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              "Lifestyle: ${userData.lifestyle}",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                color:
                                                    FitnessAppTheme.nearlyDarkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -16,
                        left: 0,
                        child: SizedBox(
                          width: 110,
                          height: 110,
                          child: Image.asset("assets/fitness_app/runner.png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
