import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mev/const/constants.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/service/api_provider.dart';
import 'package:flutter_mev/view/departments/menadzment.dart';
import 'package:flutter_mev/view/departments/odrzivi_razvoj.dart';
import 'package:flutter_mev/view/departments/racunarstvo.dart';
import 'package:flutter_mev/view/detail_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_mev/view/detail_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<MevModels> _mevModels;


  @override
  void initState() {
    super.initState();
    _mevModels = MevApiProvider().getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text(
                      'Mev Novosti',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 44,
                        color: titleTextColor,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 32),
                    child: FutureBuilder<MevModels>(
                      future: _mevModels,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Swiper(
                            itemCount: snapshot.data.novosti.length,
                            itemWidth:
                                MediaQuery.of(context).size.width - 2 * 64,
                            layout: SwiperLayout.STACK,
                            pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: secondaryTextColor,
                                  activeSize: 22,
                                  size: 10,
                                  space: 2),
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.symmetric(vertical: 40.0),
                            ),
                            itemBuilder: (context, index) {
                              var novosti = snapshot.data.novosti[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, a, b) =>
                                          DetailScreen(
                                        novosti: snapshot.data.novosti[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Card(
                                          elevation: 8.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 100),
                                                Text(
                                                  novosti.naslov,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 25,
                                                    color:
                                                        const Color(0xFF47455F),
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  novosti.podNaslov,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 18,
                                                    color: primaryTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 12),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Prikaži detalje',
                                                      style: TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontSize: 13,
                                                        color:
                                                            secondaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 8,
                                                    color: Colors.blueGrey,
                                                    spreadRadius: 3)
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: 95.0,
                                              backgroundImage:
                                                  NetworkImage(novosti.slika),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
