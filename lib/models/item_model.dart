class ItemModel {
  int? seId;
  int? itemDetailId;
  int? branchId;
  int? serialNumber;
  bool? calibratable;
  String? calibrationDate;
  bool? outOfCalibration;
  String? calibrationCertificateLink;
  String? status;
  int? id;
  bool? booked;
  Detail? detail;
  Branch? branch;

  ItemModel.fromJson(Map<String, dynamic> json) {
    seId = json['se_id'];
    itemDetailId = json['item_detail_id'];
    branchId = json['branch_id'];
    serialNumber = json['serial_number'];
    calibratable = json['calibratable'];
    calibrationDate = json['calibration_date'];
    outOfCalibration = json['out_of_calibration'];
    calibrationCertificateLink = json['calibration_certificate_link'];
    status = json['status'];
    id = json['id'];
    booked = json['booked'];
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['se_id'] = seId;
    data['item_detail_id'] = itemDetailId;
    data['branch_id'] = branchId;
    data['serial_number'] = serialNumber;
    data['calibratable'] = calibratable;
    data['calibration_date'] = calibrationDate;
    data['out_of_calibration'] = outOfCalibration;
    data['calibration_certificate_link'] = calibrationCertificateLink;
    data['status'] = status;
    data['id'] = id;
    data['booked'] = booked;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}

class Detail {
  String? name;
  String? imageLink;
  String? category;
  String? details;
  String? dataSheetLink;

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageLink = json['image_link'];
    category = json['category'];
    details = json['details'];
    dataSheetLink = json['data_sheet_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image_link'] = imageLink;
    data['category'] = category;
    data['details'] = details;
    data['data_sheet_link'] = dataSheetLink;
    return data;
  }
}

class Branch {
  String? name;

  Branch({this.name});

  Branch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
