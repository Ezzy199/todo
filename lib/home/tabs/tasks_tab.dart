import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: AppColors.gray,
          dayColor: AppColors.primary,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: AppColors.primary,
          dotColor: Colors.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en',
        ),
        SizedBox(height: 24,),
        FutureBuilder(future: FirebaseFunctions.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if (snapshot.hasError){
                return Center(
                  child: Column(
                    children: [
                      Text('Something went wrong'),
                      ElevatedButton(onPressed: () {

                      }, child: Text('Try Again'))
                    ],
                  ),
                );
              }
              var tasks=snapshot.data?.docs.map((e)=>e.data()).toList()??[];
              if (tasks.isEmpty){
                return Center(child: Text('No Tasks'),);


              }
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 12,
                    ),
                    itemBuilder:(context, index) {
                      return TaskItem(taskModel:tasks[index],);
                    }, itemCount: tasks.length),
              );

            },)

      ],
    );
  }
}

