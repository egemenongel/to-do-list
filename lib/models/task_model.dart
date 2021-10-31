class TaskModel {
  String title;
  bool? isCompleted;

  TaskModel({
    required this.title,
    this.isCompleted,
  }) {
    this.title = title;
    this.isCompleted = false;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }
}
