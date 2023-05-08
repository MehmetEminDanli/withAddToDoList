import 'package:flutter/material.dart';
import 'package:todoson/models/todo.dart';

class Todolistmodel extends StatefulWidget {
  const Todolistmodel({super.key});

  @override
  State<Todolistmodel> createState() => _TodolistmodelState();
}

class _TodolistmodelState extends State<Todolistmodel> {
  List<Todo> todolistmodel = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODOFORMAPP"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
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
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      obscureText: isObsecure,
                      decoration: InputDecoration(
                          labelText: "Title",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            child: Icon(isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      autovalidateMode: autovalidateMode,
                      onSaved: (newvalue) {
                        setState(() {
                          title = newvalue!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "boş geçilmez";
                        } else {}
                      },
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: todolistmodel.length,
                itemBuilder: (context, index) {
                  var element = todolistmodel[index];
                  return ListTile(
                    tileColor: element.isComplated!
                        ? Colors.red[100]
                        : Colors.green[100],
                    leading: Checkbox(
                        onChanged: (newValue) {
                          setState(() {
                            element.isComplated = newValue!;
                          });
                        },
                        value: element.isComplated),
                    title: Text(
                      element.title,
                      style: TextStyle(
                          decoration: element.isComplated!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    subtitle: const Text("Görevi tamamlandıysa işaretle..."),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                element.isStar = !element.isStar!;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              color: element.isStar!
                                  ? Colors.amber
                                  : Colors.black87,
                            )),
                        InkWell(
                            onTap: () {
                              setState(() {
                                todolistmodel.remove(element);
                              });
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Todo todo = Todo(
          Id: todolistmodel.isEmpty ? 1 : todolistmodel.last.Id + 1,
          title: title);

      setState(() {
        todolistmodel.add(todo);
      });

      getSuccsessAlert();
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> getSuccsessAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tebrikler'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(Icons.check, color: Colors.green, size: 90)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
