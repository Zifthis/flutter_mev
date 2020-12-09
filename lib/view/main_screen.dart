import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mev/const/constants.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/service/api_provider.dart';
import 'package:flutter_mev/view/detail_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_mev/view/detail_screen.dart';

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
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Smjerovi',
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 24,
                              color: subTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset('images/drop_down_icon.png'),
                      ),
                      underline: SizedBox(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 32),
                  child: FutureBuilder<MevModels>(
                    future: _mevModels,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Swiper(
                          itemCount: snapshot.data.novosti.length,
                          itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                          layout: SwiperLayout.STACK,
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                activeSize: 20, space: 3),
                            alignment: Alignment.bottomCenter,
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
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize: 27,
                                                  color:
                                                      const Color(0xFF47455F),
                                                  fontWeight: FontWeight.w900,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                novosti.podNaslov,
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
                                                      color: secondaryTextColor,
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
                                            backgroundColor: Colors.transparent,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: navigationColor,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('images/menu_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('images/search_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('images/profile_icon.png'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
