import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nullsafe_todo/edit_component.dart';
import 'package:nullsafe_todo/todo_list.dart';

import 'todo.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReorderableListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            key: Key("${todo.hashCode}"),
            title: Text("${todo.title}"),
            trailing: Checkbox(
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    todos[index] = todo.markDone();
                  });
                }
              },
              value: todo.done,
            ),
            onLongPress: () async {
              final newTodo = await EditDialog.show(context, todo);
              setState(() {
                todos[index] = newTodo;
              });
            },
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex--;
          }
          setState(() {
            final t = todos.removeAt(oldIndex);
            todos.insert(newIndex, t);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            final i = Random().nextInt(10000);
            todos.add(Todo(title: '${i}'));
          });
        },
      ),
    );
  }
}
