import 'package:flutter/material.dart';
import 'package:flutter_mev/const/constants.dart';

class OdrziviRazvoj extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7])),
      child: Center(
        child: Text(
          'Održivi Razvoj',
          style: TextStyle(
              fontSize: 32, fontFamily: 'Verdana', color: titleTextColor),
        ),
      ),
    );
  }
}
