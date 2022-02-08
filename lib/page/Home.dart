import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yonote/database/database.dart';
import 'package:yonote/page/acceuil.dart';
import 'package:yonote/page/account.dart';
import 'package:yonote/page/newnote.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database db;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  // Pour la nav bar
  int index = 1;
  final screen = [
    Newnote(),
    const Accueil(),
    const Account(),
  ];
  final items = <Widget>[
    const Icon(
      Icons.add_circle,
      size: 50,
      color: Colors.white,
    ),
    const Icon(Icons.home, size: 50, color: Colors.white),
    const Icon(
      Icons.account_box,
      size: 50,
      color: Colors.white,
    )
  ];

  List docs = [];
  @override
  // ignore: must_call_super
  void initState() {
    db = Database();
    db.initiliase();
    // db.read().then((value) => {
    //       setState(() {
    //         docs = value;
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: screen[index],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        height: 60,
        animationCurve: Curves.easeInOutCubicEmphasized,
        index: 1,
        animationDuration: const Duration(milliseconds: 900),
        items: items,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
        color: Colors.red,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
      //
      //
      //
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
