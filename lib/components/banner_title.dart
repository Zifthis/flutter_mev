import 'package:flutter/material.dart';
import 'package:flutter_mev/const/constants.dart';

class BannerTitle extends StatelessWidget {

  final String titleName;
  final Color color;
  BannerTitle({this.titleName, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 14.5, right: 14.5),
      child: Container(
        height: 80,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
        ),
        child: Text(
          titleName,
          style: TextStyle(
            fontFamily: 'Verdana',
            fontSize: 45,
            color: navigationColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
