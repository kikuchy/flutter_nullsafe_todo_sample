import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nullsafe_todo/todo.dart';

part 'todo_list_state.freezed.dart';

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(const []) List<Todo> todos,
    @Default(true) bool loading,
  }) = _TodoListState;
}
