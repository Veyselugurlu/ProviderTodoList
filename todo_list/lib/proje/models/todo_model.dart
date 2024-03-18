class TodoModel {
  final String id;
  final String description;
  final bool completed; // nullable değil, nullable değer içermemeli

  TodoModel({
    required this.id,
    required this.description,
     this.completed = false,
  });
}
