
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
 
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
   //state dedigimiz zman icinde todo modellerin oldugu bir liste veriyor
var eklenecekTodo = 
TodoModel(id: Uuid().v4(), description: description);

    state = [...state, eklenecekTodo]; // Yeni bir todo eklemek için state değişkenini güncelliyoruz.
  }

  void removeTodo(int index) {
    state = List.from(state)..removeAt(index); // Belirli bir index'teki todo'yu kaldırmak için state değişkenini güncelliyoruz.
  }
  void toggle(String id){
      state = [
        for(var todo in state)
        if(todo.id == id)    
        TodoModel(
          id: todo.id, 
          description: todo.description,
         completed : !todo.completed,
        )
        else todo ,
        
        ];
  }
  void edit({required String id ,required String newDescription}){
    state = [
      for(var todo in state)
      if(todo.id == id)
      TodoModel(id: id, 
      description: newDescription,
      completed: todo.completed,
      )
      else todo,
    ];
  }
  void remove(TodoModel silinecekTado){
    state = state.where((element) => element.id != silinecekTado.id).toList();

  }
int onCompletedToDoCount() {
  return state?.where((element) => element.completed != null && !element.completed!).length ?? 0;
}




}
