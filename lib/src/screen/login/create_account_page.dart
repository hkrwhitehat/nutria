import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nutria/src/service/diary_provider.dart';
import 'package:nutria/src/utilities/format.dart';
import 'package:nutria/src/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../fitness_app_home_screen.dart';
import '../fitness_app_theme.dart';

enum Gender { male, female }

class CreateAccountPage extends StatefulWidget {
  static const routeName = '/create';

  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _heightController = TextEditingController();
  final FocusNode _ageFocusNode = FocusNode();
  final TextEditingController _ageController = TextEditingController();
  final FocusNode _heightFocusNode = FocusNode();
  final TextEditingController _weightController = TextEditingController();
  final FocusNode _weightFocusNode = FocusNode();
  bool isFirst = true;
  String name = '';
  int age = 0;
  Gender sex = Gender.male;
  String gender = '';
  String enteredAmount = '';
  String status = '';
  String bmi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: FitnessAppTheme.headline,
        ),
        backgroundColor: FitnessAppTheme.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: FitnessAppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8, top: 16),
                      child: Text(
                        'User Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.1,
                            color: FitnessAppTheme.darkText),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    color: FitnessAppTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                child: Column(
                  children: <Widget>[
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
                        Text(
                          user!.displayName!,
                          style: const TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                            letterSpacing: -0.2,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                      ],
                    ),

                    ///Age
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Age : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: FitnessAppTheme.grey.withOpacity(0.5),
                          ),
                        ),
                        CustomTextField(controller: _ageController, focusNode: _ageFocusNode, inputType: TextInputType.number),
                      ],
                    ),

                    ///Sex
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sex : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: FitnessAppTheme.grey.withOpacity(0.5),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<Gender>(
                              title: const Text(
                                'Male',
                                style: FitnessAppTheme.body1,
                              ),
                              value: Gender.male,
                              groupValue: sex,
                              activeColor: FitnessAppTheme.purple,
                              onChanged: (value) {
                                setState(() {
                                  sex = value!;
                                });
                              }),
                        ),
                        Expanded(
                          child: RadioListTile<Gender>(
                              title: const Text(
                                'Female',
                                style: FitnessAppTheme.body1,
                              ),
                              value: Gender.female,
                              groupValue: sex,
                              activeColor: FitnessAppTheme.purple,
                              onChanged: (value) {
                                setState(() {
                                  sex = value!;
                                });
                              }),
                        ),
                      ],
                    ),

                    ///Weight
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Weight : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: FitnessAppTheme.grey.withOpacity(0.5),
                          ),
                        ),
                        _buildEnterAmount(
                            _weightController, _weightFocusNode, 'kg'),
                      ],
                    ),

                    ///Height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Height : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: FitnessAppTheme.grey.withOpacity(0.5),
                          ),
                        ),
                        _buildEnterAmount(
                            _heightController, _heightFocusNode, 'cm'),
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
                            double calc = double.parse(_weightController.text) /
                                pow(double.parse(_heightController.text) / 100,
                                    2);
                            setState(() {
                              bmi = calc.toStringAsFixed(1);
                              status = bmiCalculator(
                                  double.parse(_heightController.text),
                                  double.parse(_weightController.text));
                              if (sex == Gender.male) {
                                gender = 'Male';
                              } else {
                                gender = 'Female';
                              }
                            });
                            print('### name: ${user!.displayName}');
                            print('### age: ${_ageController.text}');
                            print('### sex: ${gender}');
                            print('### bmi: ${bmi}');
                            print('### status: ${status}');
                            print('### weight: ${_weightController.text}');
                            print('### height: ${_heightController.text}');

                            await Provider.of<DiaryProvider>(context,
                                    listen: false)
                                .addUser(
                                    age: int.parse(_ageController.text),
                                    gender: gender,
                                    height:
                                        double.parse(_heightController.text),
                                    weight:
                                        double.parse(_weightController.text),
                                    bmi: double.parse(bmi),
                                    status: status)
                                .whenComplete(() {
                              Provider.of<DiaryProvider>(context, listen: false)
                                  .getMyDiary(DateFormat('ddMMyyyy').format(DateTime.now()));
                              Navigator.restorablePushReplacementNamed(
                                  context, FitnessAppHomeScreen.routeName);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildEnterAmount(TextEditingController _amountController,
      FocusNode _amountFocusNode, String unit) {
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
                // print('value1 : ${value1}');
                enteredAmount = value1.toString();

                if (!isFirst) value1 = value1 * 100;
                value = NumberFormat.currency(customPattern: '###,###.##')
                    .format(value1 / 100);
                _amountController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(offset: value.length),
                );
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
