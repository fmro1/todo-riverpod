import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/models/todo_model.dart';
import 'package:todo_riverpod/pages/providers/active_todo_count/active_todo_count_provider.dart';
import 'package:todo_riverpod/pages/providers/theme/theme_provider.dart';
import 'package:todo_riverpod/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod/pages/providers/todo_list/todo_list_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  int getActiveTodoCount(List<Todo> todos) {
    return todos.where((todo) => !todo.completed).toList().length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTodoCount = ref.watch(activeTodoCountProvider);
    final todoListState = ref.watch(todoListProvider);

    if (todoListState.status == TodoListStatus.loading) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'TODO',
              style: TextStyle(fontSize: 36.0),
            ),
            const SizedBox(width: 10),
            Text(
              '($activeTodoCount/${todoListState.todos.length} item${activeTodoCount != 1 ? "s" : ""} left)',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: todoListState.status == TodoListStatus.loading
                  ? null
                  : () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
              icon: Icon(Icons.light_mode),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: todoListState.status == TodoListStatus.loading
                  ? null
                  : () {
                      ref.read(todoListProvider.notifier).getTodos();
                    },
              icon: Icon(Icons.refresh),
            ),
          ],
        )
      ],
    );
  }
}
