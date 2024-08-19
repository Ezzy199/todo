import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel ;
   TaskItem({super.key,required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: .6,
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            spacing: 8,
          ),
          SlidableAction(
            onPressed: (context) {},
            label: 'Edit',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            spacing: 8,
          ),
        ],
      ),
      child: Container(
        height: 115,
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   taskModel.title,
                    style: TextStyle(fontSize: 18, color: AppColors.primary),
                  ),
                  Text(taskModel.subTitle,
                      style: TextStyle(fontSize: 14, color: AppColors.gray)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.done,
                color: AppColors.white,
                size: 30,
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
