class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdData;


  TaskModel({this.sId, this.title, this.description, this.status, this.createdData});

  TaskModel.fromJson(Map<String, dynamic> json){
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdData = json['createdData'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdData'] = this.createdData;

    return data;

  }
}