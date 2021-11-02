class TaskModel {
  String title;
  bool? isCompleted;
  DateTime? startDate;
  DateTime? finishDate;

  TaskModel({
    required this.title,
    this.startDate,
    this.finishDate,
    this.isCompleted,
  }) {
    this.title = title;
    this.isCompleted = false;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }
}
