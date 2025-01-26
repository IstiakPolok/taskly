import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 1,
      child: ListTile(

        title: Text('Title Wii be here'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lorem Ipsum is simply dummy text"),
            Text('date 12/12/25'),
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