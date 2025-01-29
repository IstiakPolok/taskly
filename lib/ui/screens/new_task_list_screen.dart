import 'package:flutter/material.dart';
import 'package:taskly/data/models/task_count_by_status_model.dart';
import 'package:taskly/data/models/task_count_model.dart';
import 'package:taskly/data/models/task_list_by_status_model.dart';
import 'package:taskly/data/services/network_caller.dart';
import 'package:taskly/data/utils/urls.dart';
import 'package:taskly/ui/screens/add_new_task_screen.dart';
import 'package:taskly/ui/widgets/center_circular_prograss_indicator.dart';
import 'package:taskly/ui/widgets/screen_background.dart';
import 'package:taskly/ui/widgets/snack_bar_message.dart';
import 'package:taskly/ui/widgets/task_item_widget.dart';
import 'package:taskly/ui/widgets/task_status_summary_counter_widget.dart';
import 'package:taskly/ui/widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountByStatusProgress = false;
  bool _getNewTaskListInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModel;

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Visibility(
                    visible: _getNewTaskListInProgress == false,
                    replacement: const CenterCircularPrograssIndicator(),
                    child: _buildTaskListView()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: newTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            taskModel: newTaskListModel!.taskList![index],
          );
        });
  }

  Widget _buildTaskSummaryByStatus() {
    return Visibility(
      visible: _getTaskCountByStatusProgress == false,
      replacement: CircularProgressIndicator(),
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              shrinkWrap: true,
              itemCount: taskCountByStatusModel?.taskByStatusList?.length ??  0,
                itemBuilder: (context, index) {
                final TaskCountModel model = taskCountByStatusModel!.taskByStatusList![index];
                return TaskStatusSummaryCounterWidget(
                    title: model.sId ?? '',
                    count: model.sum.toString(),
                );

                }
                ),
          )
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getTaskCountByStatusProgress = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.TasklistByStatusUrl('New'));

    if (response.isSuccess) {
      newTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }
}


