import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yonote/database/database.dart';
import 'package:yonote/fonctionalite/helper.dart';
import 'package:yonote/models/note.dart';
import 'package:yonote/page/updateNote.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => AccueilState();
}

class AccueilState extends State<Accueil> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('notes').snapshots();
  late Database db;

  // Pour la nav bar
  int index = 2;

  List docs = [];
  @override
  // ignore: must_call_super
  void initState() {
    // db = Database();
    // db.initiliase();
    // db.read().then((value) => {
    //       setState(() {
    //         docs = value;
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false,
      child: SizedBox(
        width: largeur(context),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                width: largeur(context),
                height: hauteur(context) * 0.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Note',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 5),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                // margin: const EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView(
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs
                            .map((_note) => Note(
                                  time: (_note['timestamp'] as Timestamp)
                                      .toDate(),
                                  content: _note['note'],
                                  id: _note.id,
                                ))
                            .toList()
                            .map((_noteF) => Container(
                                margin: const EdgeInsets.all(10),
                                width: 10,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        2.0,
                                        3.0,
                                      ),
                                      blurRadius: 6.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                height: MediaQuery.of(context).size.width * .30,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateNote(
                                                  data: _noteF,
                                                )));
                                  },
                                  title: Text(
                                    _noteF.content,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${_noteF.time.day}-${_noteF.time.month}-${_noteF.time.year}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )))
                            .toList());
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
