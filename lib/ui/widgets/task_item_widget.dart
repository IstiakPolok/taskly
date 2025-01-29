import 'package:flutter/material.dart';
import 'package:taskly/data/models/task_model.dart';

import '../utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 1,
      child: ListTile(

        title: Text(taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ''),
            Text('Date: ${taskModel.createdData ?? ''}'),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.themeColor
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white),),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon:const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon:const Icon(Icons.edit),
                    ),


                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}