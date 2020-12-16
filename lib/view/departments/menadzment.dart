import 'package:flutter/material.dart';
import 'package:flutter_mev/components/banner_title.dart';
import 'package:flutter_mev/components/clip_block.dart';
import 'package:flutter_mev/const/constants.dart';
import 'package:flutter_mev/components/list_builder.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/service/api_provider.dart';

class Menadzment extends StatefulWidget {
  @override
  _MenadzmentState createState() => _MenadzmentState();
}

class _MenadzmentState extends State<Menadzment> {
  Future<MevModels> _mevModels;

  @override
  void initState() {
    _mevModels = MevApiProvider().getApi();
  }

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
        child: Stack(
          children: [
            Center(
              child: ClipPath(
                clipper: BackgroundClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.96,
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [menadzmentMainColor, menadzmentEndColor],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight)),
                ),
              ),
            ),
            BannerTitle(titleName: 'Menadžment', color: menadzmentMainColor,),
            Padding(
              padding: const EdgeInsets.only(top: 130.0, left: 6.7, right: 6.7, bottom: 10),
              child: NewsList(
                mevModels: _mevModels,
                newsType: '3',
                colorBorder: menadzmentMainColor,
                colorFill: menadzmentMainColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
