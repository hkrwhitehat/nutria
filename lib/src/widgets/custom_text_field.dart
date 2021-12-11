import 'package:flutter/material.dart';
import 'package:nutria/src/screen/fitness_app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    required this.inputType, this.unit,
  }) : _controller = controller, _focusNode = focusNode, super(key: key);

  final TextEditingController _controller;
  final FocusNode _focusNode;
  final TextInputType inputType;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: unit != null ? 150 : 190,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: inputType,
              decoration: const InputDecoration(
                border: InputBorder.none,
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
              // onChanged: (value) {
              //   _controller.text = value;
              // },
            ),
          ),
          unit != null ? Text(
            unit!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              letterSpacing: -0.2,
              color: FitnessAppTheme.nearlyDarkBlue,
            ),
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}