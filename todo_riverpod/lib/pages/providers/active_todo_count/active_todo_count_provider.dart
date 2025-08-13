import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/pages/providers/todo_list/todo_list_provider.dart';

part 'active_todo_count_provider.g.dart';

//usar o provider simples pois ele muda estado quando o todolist muda,
//mas ele mesmo nao tem estado proprio

@riverpod
int activeTodoCount(ActiveTodoCountRef ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.completed).toList().length;
}
