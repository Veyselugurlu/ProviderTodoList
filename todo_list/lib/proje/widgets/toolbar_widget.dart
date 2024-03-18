import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;
  Color changeColor(TodoListFilter filt){
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedToDoCount = ref.watch(unCompletedTodoCount);
    //bu providerdaki degerler degistikce bilgi edincez
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedToDoCount == 0 ? 'Tüm görevler Okey !':
            onCompletedToDoCount.toString()+ 
          " görev tamamlandı",
          overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip( //uzerine tikladndiginda verilcek yazi
          message: "All Todos", 
          child: TextButton(
          style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return changeColor(TodoListFilter.all);
            },
          ),
        ),
            onPressed: (){
            //bu butona basinca atancak degerleri verdik(hepsini)
            ref.read(todoListFilter.notifier).state = TodoListFilter.all;
          }, 
          child:const Text('All'),
          ),
        ),
        Tooltip( //uzerine tikladndiginda verilcek yazi
          message: "Only Uncompleted Todos", 
          child: TextButton(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return changeColor(TodoListFilter.active);
            },
          ),
        ),
            onPressed: (){
            ref.read(todoListFilter.notifier).state = TodoListFilter.active;

          }, 
          child: const Text('Active'),
          ),
        ),
        Tooltip( //uzerine tikladndiginda verilcek yazi
          message: "  Only Completed Todos", 
          child: TextButton( 
           style:  ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return changeColor(TodoListFilter.completed);
            },
          ),
        ),
            onPressed: (){
            ref.read(todoListFilter.notifier).state = TodoListFilter.completed;

          }, 
          child: const Text('Completed'),
          ),
        ),

      ],
    );
  }
}