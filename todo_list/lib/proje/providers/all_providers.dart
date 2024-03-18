     import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/models/todo_model.dart';
import 'package:todo_list/proje/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter{ all, active, completed}
final todoListFilter = StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider = StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: Uuid().v4(), description: "Alişveriş"),
    TodoModel(id: Uuid().v4(), description: "Market"),
    TodoModel(id: Uuid().v4(), description: "Gez"),
    TodoModel(id: Uuid().v4(), description: "Spora git"),
  ]);
});

  final filteredTodoList = Provider<List<TodoModel>>((ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(todoListProvider);

    switch(filter){
      case TodoListFilter.all :
      return todoList;
      case TodoListFilter.completed :
      return todoList.where((element) => element.completed).toList();
      case TodoListFilter.active :
      return todoList.where((element) => !element.completed).toList();
    }
  }); 
//bu sayede bunu dinleyen widged build'in sürekli tetiklenmiyor
final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

//widget tree ye saglayacagimiz degeri bilmedigimiz icin kullandik
final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});