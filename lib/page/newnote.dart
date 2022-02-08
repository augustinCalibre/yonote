import 'package:flutter/material.dart';
import 'package:yonote/database/database.dart';
import 'package:yonote/models/note.dart';
import 'package:yonote/page/Home.dart';

// ignore: must_be_immutable
class Newnote extends StatefulWidget {
  const Newnote({Key? key}) : super(key: key);

  @override
  State<Newnote> createState() => NewnoteState();
}

class NewnoteState extends State<Newnote> {
  late Database db;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    db = Database();
    db.initiliase();

    _textEditingController = TextEditingController();
  }

  // Pour desalouer une variable lorsque l'ecran se detruit

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Mofication de votre note'),
          backgroundColor: Colors.red),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              cursorColor: Colors.red,
              maxLines: 15,
              controller: _textEditingController,
              decoration: const InputDecoration(
                  focusColor: Colors.red, fillColor: Colors.red),
            ),
            ElevatedButton.icon(
              onPressed: () {
                db.add(_textEditingController.text, DateTime.now());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: '',
                          )),
                );
              },
              icon: const Icon(
                Icons.update,
                size: 18,
              ),
              label: const Text("modifier"),
            )
          ],
        ),
      ),
    );
  }
}
