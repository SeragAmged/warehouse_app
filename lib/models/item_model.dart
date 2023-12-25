class ItemModel {
  int? itemId;
  String? status;
  String? companyLended;
  int? toolId;
  int? branchId;
  String? jobAssigned;
  Tool? tool;

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    status = json['status'];
    companyLended = json['company_lended'];
    toolId = json['tool_id'];
    branchId = json['branch_id'];
    jobAssigned = json['job_assigned'];
    tool = json['tool'] != null ? Tool.fromJson(json['tool']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['status'] = status;
    data['company_lended'] = companyLended;
    data['tool_id'] = toolId;
    data['branch_id'] = branchId;
    data['job_assigned'] = jobAssigned;
    if (tool != null) {
      data['tool'] = tool!.toJson();
    }
    return data;
  }
}

class Tool {
  int? toolId;
  String? categoryName;
  int? quantity;
  String? imageLink;
  String? toolName;
  String? details;
  String? dataSheetPdfLink;

  Tool.fromJson(Map<String, dynamic> json) {
    toolId = json['tool_id'];
    categoryName = json['category_name'];
    quantity = json['quantity'];
    imageLink = json['image_link'];
    toolName = json['tool_name'];
    details = json['details'];
    dataSheetPdfLink = json['data_sheet_pdf_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tool_id'] = toolId;
    data['category_name'] = categoryName;
    data['quantity'] = quantity;
    data['image_link'] = imageLink;
    data['tool_name'] = toolName;
    data['details'] = details;
    data['data_sheet_pdf_link'] = dataSheetPdfLink;
    return data;
  }
}
