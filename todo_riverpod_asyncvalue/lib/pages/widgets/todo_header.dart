import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../models/todo_model.dart';
import '../providers/theme/theme_provider.dart';
import '../providers/todo_list/todo_list_provider.dart';
import '../providers/todo_list/todo_list_state.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = SizedBox.shrink();

  Widget getActiveTodoCount(List<Todo> todos) {
    final totalCount = todos.length;
    final activeTodoCount =
        todos.where((todo) => !todo.completed).toList().length;
    prevTodoCountWidget = Text(
      '($activeTodoCount/$totalCount item${activeTodoCount != 1 ? "s" : ""} left)',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.blue[900],
      ),
    );
    return prevTodoCountWidget;
  }

  @override
  Widget build(BuildContext context) {
    final todoListState = ref.watch(todoListProvider);

    switch (todoListState) {
      case TodoListStateLoading():
        context.loaderOverlay.show();
      default:
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
            switch (todoListState) {
              TodoListStateSuccess(todos: var todos) =>
                getActiveTodoCount(todos),
              _ => prevTodoCountWidget,
            },
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: Icon(Icons.light_mode),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
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
