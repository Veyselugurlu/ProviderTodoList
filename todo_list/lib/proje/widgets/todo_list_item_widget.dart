import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/proje/models/todo_model.dart';
import 'package:todo_list/proje/providers/all_providers.dart';

class TodoLitItemWidget extends ConsumerStatefulWidget{

    TodoLitItemWidget({Key? key}) : super(key: key);  //item uzerinden decscriptionu gelcek 

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoLitItemWidget();
}
class _TodoLitItemWidget extends ConsumerState<TodoLitItemWidget>{
  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFocusNode = FocusNode();
    _textController = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textFocusNode.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext contex) {
    final currentTodoItem = ref.watch(currentTodoProvider);

    return Focus(
      onFocusChange: (isFocused)  {   //degere basildiginda guncelleme yapacak
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });
          //editleme işlemi
          ref.read(todoListProvider.notifier).edit(id: currentTodoItem.id, newDescription: _textController.text);
        }
  
      },
      child: ListTile(
        onTap: (){
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _textController.text = currentTodoItem.description;
          });
         
        },
        leading: Checkbox(
          value: currentTodoItem.completed ?? false, // null kontrolü yaparak atama
          onChanged: (value){
          ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
        },
        ),
        title : _hasFocus ?  TextField(
          controller: _textController,
          focusNode: _textFocusNode,
        ) : Text(currentTodoItem.description),
      ),
    );
  }

}

// ignore: must_be_immutable
