import 'package:flutter/material.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/view/detail_screen.dart';

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
                var mevNovosti = snapshot.data.novosti[index];
                bool isEmpty;
                if (mevNovosti.tipNovosti == newsType) {
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
                    margin: const EdgeInsets.only(bottom: 6, top: 6),
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
                                mevNovosti.slika,
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mevNovosti.naslov,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                mevNovosti.podNaslov,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                                maxLines: 2,
                              ),
                              Text(
                                mevNovosti.datumObjave.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, a, b) =>
                                          DetailScreen(
                                            novosti: snapshot.data
                                                .novosti[index],
                                          ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Prikaži više',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
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
