import 'package:flutter/material.dart';
import 'package:flutter_mev/components/clip_block.dart';
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
        child: ClipPath(
          clipper: BackgroundClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [razvojMainColor, razvojEndColor],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight)),
          ),
        ),
      ),
    );
  }
}
