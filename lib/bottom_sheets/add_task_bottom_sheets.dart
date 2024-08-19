import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate=DateTime.now();
  var titleController= TextEditingController();
  var subTitleController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Task',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: subTitleController,
            decoration: InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Select Time',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 18,
          ),
          InkWell(
            onTap: () {
              selectDateFun();
            },
            child: Text(
              selectedDate.toString().substring(0,10) ,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task =TaskModel(
                  title: titleController.text,
                  subTitle: subTitleController.text,
                  date: selectedDate.millisecondsSinceEpoch);
              FirebaseFunctions.addTask(task).then((Value){
                Navigator.pop(context);
              });

            },
            child: Text(
              'Add Task',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          )
        ],
      ),
    );
  }

  selectDateFun() async{
    DateTime? chosenDate =await
    showDatePicker(
        context: context,
        builder: (context,child)=>Theme(data:Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onSurface: Colors.white,
            surface: Colors.black
          )
        ) , child: child!),
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate!=null){
      selectedDate = chosenDate;
      setState(() {

      });
    }
  }
}
