import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nullsafe_todo/repository.dart';
import 'package:nullsafe_todo/todo.dart';
import 'package:nullsafe_todo/todo_list_state.dart';
import 'package:state_notifier/state_notifier.dart';

final todoListControllerProvider = StateNotifierProvider(
  (ref) => TodoListController(repository: TodoRepository()),
);

class TodoListController extends StateNotifier<TodoListState> {
  final TodoRepository _repository;

  TodoListController({
    required TodoRepository repository,
  })   : _repository = repository,
        super(TodoListState()) {
    _repository.loadAllTodo().then((todos) {
      state = state.copyWith(
        todos: todos,
        loading: false,
      );
    });
  }

  void replaceTodo(int index, Todo newTodo) {
    final todos = state.todos;
    todos[index] = newTodo;
    state = state.copyWith(todos: todos);
    _repository.saveAllTodo(todos);
  }

  void appendTodo(Todo newTodo) {
    final todos = [...state.todos, newTodo];
    state = state.copyWith(todos: todos);
    _repository.saveAllTodo(state.todos);
  }
}
