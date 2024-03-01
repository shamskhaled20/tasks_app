import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting
import '../../view_model/get_tasks_cubit/get_tasks_cubit.dart';
import '../../view_model/get_tasks_cubit/get_tasks_status.dart';
class ListOfTasks extends StatelessWidget {
  const ListOfTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirestoreGetTasksCubit()..fetchTasks(),
      child: _buildTasksList(context),
    );
  }

  Widget _buildTasksList(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.7,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
                (innerIndex) => _buildTaskItem(index * 3 + innerIndex + 1, context),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildTaskItem(index + 1, context);
      },
    );
  }

  Widget _buildTaskItem(int taskNumber, BuildContext context) {
    return BlocBuilder<FirestoreGetTasksCubit, FirestoreGetTasksStatus>(
      builder: (context, state) {
        if (state == FirestoreGetTasksStatus.loading) {
          return CircularProgressIndicator();
        } else if (state == FirestoreGetTasksStatus.success) {
          final tasks = BlocProvider.of<FirestoreGetTasksCubit>(context).tasks;
          print("Total tasks: ${tasks.length}, requested task number: $taskNumber");
          if (tasks != null && tasks.isNotEmpty && taskNumber <= tasks.length) { // Check if tasks is not null and not empty
            final task = tasks[taskNumber - 1];
            return _buildTaskItemUI(task);
          } else {
            return Text('Task not found');
          }
        } else {
          return Text('Failed to fetch tasks');
        }
      },
    );
  }

  Widget _buildTaskItemUI(Map<String, dynamic> task) {
    String title = task['title'];
    String dateString = task['date'];

    if (dateString != null && dateString.isNotEmpty) {
      try {
        DateTime dateTime;
        String formattedDate;
        if (dateString.contains('(')) { // Check if the string contains the day of the week
          // Parsing "Fri (15/03/2024)" format
          final extractedDate = dateString.split('(')[1].split(')')[0].trim();
          dateTime = DateFormat('dd/MM/yyyy').parse(extractedDate);
          formattedDate = DateFormat('EEE, dd/MM/yyyy').format(dateTime);
        } else {
          // Parsing "15/03/2024" format
          dateTime = DateFormat('dd/MM/yyyy').parse(dateString);
          formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
        }
        return _buildTaskUIWithDate(title, formattedDate);
      } catch (e) {
        print("Error parsing date: $e");
        return _buildTaskUIWithDate(title, 'Invalid Date');
      }
    } else {
      print("Date string is null or empty");
      return SizedBox();
    }
  }


  Widget _buildTaskUIWithDate(String title, String formattedDate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          height: 79,
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(bottom: 8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Due Date: ${formattedDate}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Image.asset("images/mark.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
