class TodoData {
  String? id;
  String? todoText;
  bool isDone;

  TodoData({
    required this.id,
    required this.todoText,
    this.isDone =false,
    
  });

  static List<TodoData> todoList() {
    return [
      TodoData(id: '1', todoText: 'Buy milk', isDone: true),
      TodoData(id: '2', todoText: 'Walk dog', isDone: true),
      TodoData(id: '3', todoText: 'Do homework', isDone: false),

    ];
  }
}