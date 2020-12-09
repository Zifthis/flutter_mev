import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/const/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  final Novosti novosti;

  const DetailScreen({Key key, this.novosti});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.memoryNetwork(
                                fadeInDuration:
                                    const Duration(milliseconds: 500),
                                fit: BoxFit.cover,
                                height: 300,
                                placeholder: kTransparentImage,
                                image: novosti.slika),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          novosti.naslov,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 56,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          novosti.podNaslov,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 31,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        SizedBox(height: 15),
                        Text(
                          novosti.tekst ?? '',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: contentTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
