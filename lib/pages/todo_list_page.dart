import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _controller = TextEditingController();
  final List<TodoModel> _todoList = [
    TodoModel(text: 'ทดสอบ', isDone: false),
    TodoModel(text: 'Hello Flutter', isDone: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.check_box),
            SizedBox(width: 8.0),
            Text('My ToDo'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              itemCount: _todoList.length,
              itemBuilder: _buildTodoItem,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter new ToDo',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _handleClickAddTodo,
                  child: const Text('ADD'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(BuildContext context, int index) {
    final todoItem = _todoList[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Checkbox(
                value: todoItem.isDone,
                onChanged: (value) {
                  setState(() {
                    todoItem.isDone = value!;
                  });
                },
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  todoItem.text,
                  style: TextStyle(
                    decoration: todoItem.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    _todoList.remove(todoItem);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleClickAddTodo() {
    var input = _controller.text;
    if (input.trim() != '') {
      setState(() {
        _todoList.add(TodoModel(text: input, isDone: false));
        _controller.clear();
      });
    }
  }
}
