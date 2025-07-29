// Model for to-do item
class TodoEntity {
  final String id;
  final String title;
  bool isCompleted;

  TodoEntity({required this.id, required this.title, this.isCompleted = false});
}
