import 'package:flutter/material.dart';
import 'package:flutter_mev/models/mev_models.dart';

class NewsList extends StatelessWidget {
  const NewsList(
      {@required Future<MevModels> mevModels, newsType, colorBorder, colorFill})
      : _mevModels = mevModels,
        colorFill = colorFill,
        colorBorder = colorBorder,
        newsType = newsType;

  final Future<MevModels> _mevModels;
  final String newsType;
  final Color colorBorder;
  final Color colorFill;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MevModels>(
      future: _mevModels,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.novosti.length,
              itemBuilder: (context, index) {
                var racNovosti = snapshot.data.novosti[index];
                bool isEmpty;
                if (racNovosti.tipNovosti == newsType) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorBorder,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: colorFill.withOpacity(0.5),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                racNovosti.naslov,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
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
      },
    );
  }
}