import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/pages/providers/todo_item/todo_item_provider.dart';
import 'package:todo_riverpod/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod/pages/providers/todo_list/todo_list_state.dart';
import 'package:todo_riverpod/pages/widgets/todo_item.dart';

import '../providers/filtered_todos/filtered_todos_provider.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(todoListProvider.notifier).getTodos();
    });
  }

  Widget prevTodosWidget = const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    ref.listen<TodoListState>(todoListProvider, (previous, next) {
      if (next.status == TodoListStatus.failure) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("ERROR"),
                content: Text(next.error),
              );
            });
      }
    });

    final todoListState = ref.watch(todoListProvider);

    switch (todoListState.status) {
      case TodoListStatus.initial:
        return const SizedBox.shrink();
      case TodoListStatus.loading:
        return prevTodosWidget;
      case TodoListStatus.succes:
        final filteredTodos = ref.watch(filteredTodosProvider);

        prevTodosWidget = ListView.separated(
          itemCount: filteredTodos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            final todo = filteredTodos[index];
            return ProviderScope(
              overrides: [
                todoItemProvider.overrideWithValue(todo),
              ],
              child: const TodoItem(),
            );
          },
        );
        return prevTodosWidget;
      case TodoListStatus.failure when prevTodosWidget is SizedBox:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                todoListState.error,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ref.read(todoListProvider.notifier).getTodos();
                },
                child: const Text(
                  'Please Retry!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      case TodoListStatus.failure:
        return prevTodosWidget;
    }
  }
}
