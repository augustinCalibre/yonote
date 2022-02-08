class Note {
  final String id;
  final String content;
  final DateTime time;

  Note({required this.content, required this.id, required this.time})
      : assert(id.isNotEmpty),
        assert(content.isNotEmpty);
}
