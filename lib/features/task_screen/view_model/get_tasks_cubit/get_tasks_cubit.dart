
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/task_screen/data/get_tasks_firebase.dart';
import 'package:tasks_app/features/task_screen/view_model/get_tasks_cubit/get_tasks_status.dart';

class FirestoreGetTasksCubit extends Cubit<FirestoreGetTasksStatus> {
  List<Map<String, dynamic>> _tasks = [];

  FirestoreGetTasksCubit() : super(FirestoreGetTasksStatus.initial);

  List<Map<String, dynamic>> get tasks => _tasks;

  void fetchTasks() async {
    try {
      emit(FirestoreGetTasksStatus.loading);
      final tasks = await FireBaseServiceGetTasks.getTasks().first;
      _tasks = tasks;
      emit(FirestoreGetTasksStatus.success);
    } catch (error) {
      emit(FirestoreGetTasksStatus.failure);
    }
  }
}