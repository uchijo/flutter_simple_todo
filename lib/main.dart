import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // todoを保持するリスト
  final _todos = <Todo>[];

  // 入力フォームのコントローラ
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // todoのリスト。expandedにしないと描画エラーになる
        Expanded(
          child: ListView(
            children: [
              ..._todos.map(
                // todoをListTileウィジェットに変換
                (e) => ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.description),
                  // 押したら削除するボタン
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _todos.removeWhere((element) => element.id == e.id);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // 画面下部の入力フォーム
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                controller: _descriptionController,
              ),
            ),

            // 押すと現在の入力内容をリストに追加
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _todos.add(
                    Todo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                  );
                });
                _titleController.clear();
                _descriptionController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        )
      ],
    );
  }
}

// todoを表すクラス
class Todo {
  final String title;
  final String description;
  final String id = DateTime.now().millisecondsSinceEpoch.toString();

  Todo({
    required this.title,
    required this.description,
  });
}
