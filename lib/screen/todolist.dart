import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TodoList"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        todoList.clear();
                        setState(() {
                          for (var i = 0; i < 100; i++) {
                            Map<String, dynamic> todo = {
                              "id": i + 1,
                              "title": "Başlık ${i + 1}",
                              "isComplated": i % 2 == 0 ? true : false
                            };
                            todoList.add(todo);
                          }
                        });
                      },
                      child: const Text("TodoList Üret")),
                )),
            Expanded(
              flex: 3,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  var element = todoList[index];
                  return ListTile(
                    tileColor: element["isComplated"]
                        ? Colors.red[100]
                        : Colors.green[100],
                    leading: Checkbox(
                        onChanged: (newValue) {
                          setState(() {
                            element["isComplated"] = newValue;
                          });
                        },
                        value: element["isComplated"]),
                    title: Text(
                      element["title"],
                      style: TextStyle(
                          decoration: element["isComplated"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    subtitle: const Text("Görevi tamamlandıysa işaretle..."),
                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            todoList.remove(element);
                          });
                        },
                        child: const Icon(Icons.delete)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
