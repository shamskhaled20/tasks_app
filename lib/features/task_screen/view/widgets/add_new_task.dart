import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/task_screen/view_model/add_task_cubit/add_task_cubit.dart';
import 'package:tasks_app/features/task_screen/view_model/add_task_cubit/add_task_status.dart';
import 'package:intl/intl.dart';

import '../../../../constant.dart';
import 'custom_buttoms.dart';
import 'custom_text_form_field.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirestoreCubit(), // Provide your FirestoreCubit
      child: BlocConsumer<FirestoreCubit, FirestoreStatus>(
        listener: (context, state) {
          if (state == FirestoreStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data added successfully!')),
            );
          } else if (state == FirestoreStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add data. Please try again.')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context); // Close the screen
                    },
                  ),
                ),
                    Text(
                      'Create New Task',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                SizedBox(height: 10.0),
                CustomTextFormField(
                  controller: titleController,
                  hintText: 'Task title',
                ),
                SizedBox(height: 20.0),
                CustomTextFormField(
                  controller: dateController,
                  hintText: 'Due date (dd/MM/yyyy)',
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      // Format the selected date
                      String selectedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      // Get the day of the week from the selected date
                      String dayOfWeek = DateFormat('E').format(pickedDate); // This will return the abbreviated day of the week (e.g., "Mon", "Tue", etc.)
                      String formattedDate = '$dayOfWeek ($selectedDate)'; // Combine date and day of the week
                      // Update the text field with the selected date
                      dateController.text = formattedDate;
                    }
                  },
                ),
                SizedBox(height: 30.0),
            SizedBox(
              height: 60,
              child: CustomButtom(
                onPress: () {
                  // Save button action
                        final String title = titleController.text;
                        final String dateString = dateController.text;
                        context.read<FirestoreCubit>().addData(
                          title: title,
                          dateString: dateString,
                        );
                  // Pass the data somewhere or handle it accordingly
                },
                title: 'Save Task',
                buttonColor: Colors.white,
                buttonBackgroundColor: KprimaryColour,
              ),)
              ],
            ),
          );
        },
      ),
    );
  }
}

