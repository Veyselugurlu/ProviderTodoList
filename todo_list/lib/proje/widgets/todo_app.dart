import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/providers/all_providers.dart';
import 'package:todo_list/proje/widgets/furure_provider_page.dart';
import 'package:todo_list/proje/widgets/title_widget.dart';
import 'package:todo_list/proje/widgets/todo_list_item_widget.dart';
import 'package:todo_list/proje/widgets/toolbar_widget.dart';

class ToDoApp extends ConsumerWidget {
   ToDoApp({super.key});

  final newToDoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //kullanici butona bastigi zaman tetiklenecek
   var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 30),  
          children: [
           const TitleWidget(),
           TextField(
            controller: newToDoController,
            decoration: 
            const InputDecoration(
              labelText: "Neler Yapıcaksın Bugün ?"),
              onSubmitted: (newToDo) {
                //notifier diyerek todolist managere erisiyoruz.
                ref.read(todoListProvider.notifier).addTodo(newToDo);
              },
           ),
           const SizedBox(height: 15,),
            ToolBarWidget(),
            allTodos.length == 0 ? const Center(child: Text('Bu Koşullarda Herhangi bir görev yok')) : const SizedBox(),
           for(var i =0 ; i<allTodos.length; i++)
               Dismissible(key: ValueKey(allTodos[i].id),
               onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
               },
               //butun uygulamadaki providerlara eriscek
               child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: TodoLitItemWidget())
                ),
                ElevatedButton(onPressed: (){
                  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>FutureProviderExample(),
                  ));
                }, child: const Text("Future Provider Example"),
                ),
          ],
      ),
    );
  }
}