import 'package:flutter/material.dart';
import 'package:flutter_mev/models/mev_models.dart';
import 'package:flutter_mev/service/api_provider.dart';
import 'package:flutter_mev/view/departments/racunarstvo.dart';
import 'package:flutter_mev/view/detail_screen.dart';

class NewsList extends StatefulWidget {
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
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  Future<MevModels> refreshList() async {
    MevApiProvider apiProvider = MevApiProvider();
    return apiProvider.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        refreshList();
      },
      child: FutureBuilder<MevModels>(
        future: widget._mevModels,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.novosti.length,
                itemBuilder: (context, index) {
                  var mevNovosti = snapshot.data.novosti[index];
                  if (mevNovosti.tipNovosti == widget.newsType) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.colorBorder,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: widget.colorFill.withOpacity(0.5),
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
                                          novosti: snapshot.data.novosti[index],
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
      ),
    );
  }
}
