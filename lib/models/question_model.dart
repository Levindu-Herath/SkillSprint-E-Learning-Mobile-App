class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

//constructor
  Question({required this.id, required this.title, required this.options});

//print the questions on colsole
  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
