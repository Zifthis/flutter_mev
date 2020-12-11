import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mev/view/departments/menadzment.dart';
import 'package:flutter_mev/view/departments/odrzivi_razvoj.dart';
import 'package:flutter_mev/view/departments/racunarstvo.dart';
import 'package:flutter_mev/view/main_screen.dart';
import 'const/constants.dart';

void main() {
  runApp(MevApp());
}

class MevApp extends StatefulWidget {
  @override
  _MevAppState createState() => _MevAppState();
}

class _MevAppState extends State<MevApp> {
  int _pageIndex = 0;

  final MainScreen _mainScreen = MainScreen();
  final Racunarstvo _racunarstvo = Racunarstvo();
  final Menadzment _menadzment = Menadzment();
  final OdrziviRazvoj _odrziviRazvoj = OdrziviRazvoj();

  Widget _showPage = new MainScreen();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _mainScreen;
        break;
      case 1:
        return _racunarstvo;
        break;
      case 2:
        return _menadzment;
        break;
      case 3:
        return _odrziviRazvoj;
        break;
      default:
        return _mainScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: gradientEndColor,
          index: _pageIndex,
          height: 65.0,
          items: [
            Icon(Icons.home, size: 30),
            Icon(
              Icons.add,
              size: 30,
            ),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: _showPage,
      ),
    );
  }
}
