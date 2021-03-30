class Todo {
  final String title;
  final bool done;

  Todo({required this.title, this.done = false});

  Todo markDone() => Todo(title: title, done: true,);
}