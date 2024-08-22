import 'dart:async';

class PollingService {
  final Map<String, Timer> _pollingTasks = {};

  // Добавить новую polling-задачу
  void addPollingTask(String taskId, Duration interval, Function() task) {
    // Если задача с таким ID уже существует, сначала удалим ее
    removePollingTask(taskId);

    // Создаем новый Timer, который будет периодически выполнять задачу
    _pollingTasks[taskId] = Timer.periodic(interval, (_) => task());
  }

  // Удалить конкретную polling-задачу по ID
  void removePollingTask(String taskId) {
    if (_pollingTasks.containsKey(taskId)) {
      _pollingTasks[taskId]?.cancel();
      _pollingTasks.remove(taskId);
    }
  }

  // Удалить все polling-задачи
  void removeAllPollingTasks() {
    _pollingTasks.forEach((_, timer) => timer.cancel());
    _pollingTasks.clear();
  }

  // Получить список всех активных задач
  List<String> getActiveTasks() {
    return _pollingTasks.keys.toList();
  }
}
