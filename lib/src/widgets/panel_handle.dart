import 'package:flutter/material.dart';

class PanelHandle extends StatelessWidget {
  const PanelHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Center(
          child: Container(
        height: 8,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey.withOpacity(0.3),
        ),
      )),
    );
  }
}
