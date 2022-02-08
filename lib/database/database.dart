import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yonote/models/note.dart';
import 'package:yonote/page/updateNote.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  // // For Read valu
  // Future<List<Note>> read() async {
  //   QuerySnapshot querySnapshot;
  //   try {
  //     querySnapshot =
  //         await firestore.collection('notes').orderBy('timestamp').get();
  //     final __notes = querySnapshot.docs;

  //     if (__notes.isNotEmpty) {
  //       final _notes = __notes
  //           .map((_note) => Note(content: _note['note'], id: _note.id,time: _note['time']))
  //           .toList();
  //       return _notes;
  //       // for (var doc in querySnapshot.docs.toList()) {
  //       //   Map a = {
  //       //     'id': doc.id,
  //       //     'note': doc['note'],
  //       //   };
  //       //   docs.add(a);
  //       // }
  //       // return docs;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<void> update(String id, String note) async {
    try {
      await firestore.collection('notes').doc(id).update({'note': note});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> add(String note, DateTime date) async {
    try {
      await firestore
          .collection('notes')
          .add({'note': note, 'timestamp': date});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection('notes').doc(id).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
