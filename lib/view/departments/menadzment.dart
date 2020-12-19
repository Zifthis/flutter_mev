import 'package:flutter/material.dart';
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
  bool isSearching = false;


  @override
  void initState() {
    _mevModels = MevApiProvider().getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () {
              setState(() {
                this.isSearching = false;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                this.isSearching = true;

              });
            },
          ),
        ],
        backgroundColor: Colors.lightBlue,
        title: !isSearching
            ? Text(
          'Menadžment',
          style: TextStyle(
            fontFamily: 'Verdana',
            fontSize: 20,
            color: Colors.white,
          ),
        )
            : TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Search here'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: ClipPath(
                    clipper: BackgroundClipper(),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.96,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.85,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [menadzmentMainColor, menadzmentEndColor],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
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
        ),
      ),
    );
  }
}

