class DocumnetListModel {
  String? sId;
  String? emailId;
  String? taskId;
  String? documnetName;
  String? documentDescription;
  String? fileId;
  String? documentType;
  String? url;
  String? createdDate;
  String? updatedDate;

  DocumnetListModel(
      {this.sId,
      this.emailId,
      this.taskId,
      this.documnetName,
      this.documentDescription,
      this.fileId,
      this.documentType,
      this.url,
      this.createdDate,
      this.updatedDate});

  DocumnetListModel.fromJson(Map<dynamic, dynamic> json) {
    sId = json['_id'];
    emailId = json['emailId'];
    taskId = json['task_id'];
    documnetName = json['documnetName'];
    documentDescription = json['documentDescription'];
    fileId = json['fileId'];
    documentType = json['documentType'];
    url = json['url'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['emailId'] = emailId;
    data['task_id'] = taskId;
    data['documnetName'] = documnetName;
    data['documentDescription'] = documentDescription;
    data['fileId'] = fileId;
    data['documentType'] = documentType;
    data['url'] = url;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
