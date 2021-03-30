import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nullsafe_todo/edit_compoment_1.dart';
import 'package:nullsafe_todo/repository.dart';
import 'package:nullsafe_todo/todo.dart';
import 'package:nullsafe_todo/todo_list_controller.dart';
import 'package:nullsafe_todo/todo_list_state.dart';

class TodoListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(todoListControllerProvider.state);
    return Scaffold(
      body: state.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.done,
                    onChanged: (checked) {
                      watch(todoListControllerProvider).replaceTodo(
                        index,
                        Todo(title: todo.title, done: checked ?? false),
                      );
                    },
                  ),
                  onLongPress: () async {
                    final result = await EditDialog.show(context, todo);
                    if (result != null) {
                      watch(todoListControllerProvider)
                          .replaceTodo(index, result);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await EditDialog.show(context);
          if (result != null) {
            watch(todoListControllerProvider).appendTodo(result);
          }
        },
      ),
    );
  }
}
