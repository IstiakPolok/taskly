import 'package:flutter/material.dart';
import 'package:taskly/data/services/network_caller.dart';
import 'package:taskly/data/utils/urls.dart';
import 'package:taskly/ui/utils/app_colors.dart';
import 'package:taskly/ui/widgets/center_circular_prograss_indicator.dart';
import 'package:taskly/ui/widgets/screen_background.dart';
import 'package:taskly/ui/widgets/snack_bar_message.dart';
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
  bool _addNewtaskInPrograss = false; 


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
                   Text("Add New Task", style: textTheme.titleLarge),
                   const SizedBox(height: 16),
                   TextFormField(
                     controller: _titleEditingController,
                     decoration: const InputDecoration(
                       hintText: 'Title',
                     ),
                     validator: (String? value){
                       if(value?.trim().isEmpty ?? true){
                         return "Enter Your Title Here";
                       }
                       return null;
                     },
                   ),
                   const SizedBox(height: 8),
                   TextFormField(
                     controller: _descriptionEditingController,
                     maxLines: 6,
                     decoration: const InputDecoration(
                       hintText: 'Description',
                     ),
                     validator: (String? value){
                       if(value?.trim().isEmpty ?? true){
                         return "Enter Your Description Here";
                       }
                       return null;
                     },
                   ),
                   const SizedBox(height: 16),
                   Visibility(
                     visible: _addNewtaskInPrograss == false,
                     replacement: const CenterCircularPrograssIndicator(),
                     child: ElevatedButton(onPressed: (){
                       if (_formKey.currentState!.validate()){
                         _createNewtask();
                       }
                     }, child: Icon(Icons.arrow_circle_right_outlined)),
                   )

                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _createNewtask() async{
    _addNewtaskInPrograss = true;
    setState(() {});
    Map<String, dynamic> requestBody ={
      "title":_titleEditingController.text.trim(),
      "description":_descriptionEditingController.text.trim(),
      "status":"New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest
      (url: Urls.createTaskUrl, body: requestBody);
    _addNewtaskInPrograss = false;
    setState(() {});
    if(response.isSuccess){
      _clearTextField();
      showSnackBarMessage(context, "New Task Added");

    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextField(){
    _titleEditingController.clear();
    _descriptionEditingController.clear();
  }
  
  
  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

}
