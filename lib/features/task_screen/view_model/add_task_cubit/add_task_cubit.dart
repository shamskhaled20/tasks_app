import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/task_screen/data/add_task_firebase.dart';
import 'package:tasks_app/features/task_screen/view_model/add_task_cubit/add_task_status.dart';
class FirestoreCubit extends Cubit<FirestoreStatus> {
  FirestoreCubit() : super(FirestoreStatus.initial);

  void addData({required String title, required String dateString}) {
    try {
      FirebaseService.addData(title, dateString);
      emit(FirestoreStatus.success); // Indicate success
    } catch (error) {
      emit(FirestoreStatus.failure); // Indicate failure
    }
  }
}
