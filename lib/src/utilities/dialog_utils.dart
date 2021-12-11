import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context){
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  });
}

void dismissDialog(BuildContext context){
  Navigator.pop(context);
}