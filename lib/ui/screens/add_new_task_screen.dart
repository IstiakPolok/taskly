import 'package:flutter/material.dart';
import 'package:taskly/ui/utils/app_colors.dart';
import 'package:taskly/ui/widgets/screen_background.dart';
import 'package:taskly/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                 children: [
                   const SizedBox(height: 32),
                   Text("Add New Tasl", style: textTheme.titleLarge),
                   const SizedBox(height: 16),
                   TextFormField(
                     controller: _titleEditingController,
                     decoration: const InputDecoration(
                       hintText: 'Title',
                     ),
                   ),
                   const SizedBox(height: 8),
                   TextFormField(
                     controller: _descriptionEditingController,
                     maxLines: 6,
                     decoration: const InputDecoration(
                       hintText: 'Description',
                     ),
                   ),
                   const SizedBox(height: 16),
                   ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined))

                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

}
