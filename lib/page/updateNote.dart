import 'package:flutter/material.dart';
import 'package:yonote/database/database.dart';
import 'package:yonote/models/note.dart';

// ignore: must_be_immutable
class UpdateNote extends StatefulWidget {
  UpdateNote({Key? key, required this.data}) : super(key: key);
  Note data;

  @override
  State<UpdateNote> createState() => UpdateNoteState();
}

class UpdateNoteState extends State<UpdateNote> {
  late Database db;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    db = Database();
    db.initiliase();

    _textEditingController = TextEditingController(text: widget.data.content);
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
          actions: [
            IconButton(
                onPressed: () {
                  db.delete(widget.data.id);

                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.delete))
          ],
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
                db.update(widget.data.id, _textEditingController.text);
                Navigator.pop(context, true);
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
