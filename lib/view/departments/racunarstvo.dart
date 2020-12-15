import 'package:flutter/material.dart';
import 'package:flutter_mev/components/clip_block.dart';
import 'package:flutter_mev/const/constants.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/service/api_provider.dart';

class Racunarstvo extends StatefulWidget {
  @override
  _RacunarstvoState createState() => _RacunarstvoState();
}

class _RacunarstvoState extends State<Racunarstvo> {
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
                          colors: [racunarstvoMainColor, racunarstvoEndColor],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight)),
                ),
              ),
            ),
            FutureBuilder<MevModels>(
                future: _mevModels,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.novosti.length,
                        itemBuilder: (context, index) {
                          var racNovosti = snapshot.data.novosti[index];
                          bool isEmpty;
                          if (racNovosti.tipNovosti == '2') {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: racunarstvoMainColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: racunarstvoMainColor.withOpacity(0.5),
                              ),
                              height: 100,
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          racNovosti.slika,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          racNovosti.naslov,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          racNovosti.podNaslov,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                          maxLines: 3,
                                        ),
                                        Text(
                                          racNovosti.datumObjave.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Text('');
                          }
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
