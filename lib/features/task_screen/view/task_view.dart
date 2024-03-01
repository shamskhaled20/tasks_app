import 'package:flutter/material.dart';
import 'package:tasks_app/constant.dart';
import 'package:tasks_app/features/task_screen/view/widgets/add_new_task.dart';
import 'package:tasks_app/features/task_screen/view/widgets/custom_buttoms.dart';
import 'package:tasks_app/features/task_screen/view/widgets/list_of_tasks.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth >= 600) {
              // If the screen width is greater than or equal to 600 (tablet or desktop)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildForMobile(context),
                   ElevatedButton(
            onPressed: () {
            showDialog(context: context, builder:  (BuildContext context){
              return AlertDialog(
                contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0), // Set the content padding to control the size
                content: SizedBox(
                  height: 300,
                  width: 400,
                  child: AddNewTask()),
              );
            });
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(16), // Adjust padding as needed
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Set border radius
                ),
              ),
               backgroundColor: MaterialStateProperty.all<Color>(KprimaryColour),
            ),
            child: Icon(Icons.add , color: Colors.white,),
          ),
                ],
              );
            } else {
              // If the screen width is less than 600 (mobile)
              return _buildForMobile(context);
            }
          },
        ),
         ListOfTasks(),
         LayoutBuilder(
          builder: (BuildContext context , BoxConstraints constraints) {
       if (constraints.maxWidth>=600){
        return Container(child: Text(""),);
       } else{
             return Column(
               children: [
                  const SizedBox(height: 10,),
                 SizedBox(
                  height: 60,
                  width:double.infinity ,
                   child: CustomButtom(onPress: (){
                     showModalBottomSheet(
                        context: context,
                       backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            height:300,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0),
                                ),
                              ),
                            child: AddNewTask()
                          );
                        },
                      );
                   },
                    title: "Create Task", buttonColor: Colors.white, buttonBackgroundColor: KprimaryColour),
                 ),
               ],
             );
       }
         },)
        ],),
      ),
    );
  }
    Widget _buildForMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text("Good Morning ",style: TextStyle(fontSize: 30,color: Colors.black),),
        const SizedBox(height: 10,),
        Row(children: [
         CustomButtom(
           heightButtom: 21,
           borderRadius: 20,
          onPress: (){},
          title: "All",
           buttonColor: Colors.white,
           buttonBackgroundColor:KprimaryColour, ),

           const SizedBox(width: 5,),
            CustomButtom(
              heightButtom: 21,
              borderRadius: 20,
          onPress: (){},
          title: "Not Done",
           buttonColor: KprimaryColour,
           buttonBackgroundColor:  Colors.green.shade50),

 const SizedBox(width: 5,),
            CustomButtom(
              heightButtom: 21,
              borderRadius: 20,
          onPress: (){},
          title: "Done",
           buttonColor: KprimaryColour,
           buttonBackgroundColor:  Colors.green.shade50)
        ],)
        
      ],
    );
  }
}