class TaskModel {
  String title;
  bool? isCompleted;
  String? startTime;
  String? finishTime;
  String? duration;

  TaskModel({
    required this.title,
    this.startTime,
    this.finishTime,
    this.duration,
    this.isCompleted,
  }) {
    this.title = title;
    this.isCompleted = false;
    this.startTime = startTime;
    this.finishTime = finishTime;
    this.duration = duration;
  }

  void toggle() {
    isCompleted = !isCompleted!;
  }
}
