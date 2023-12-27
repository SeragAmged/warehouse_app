class UserModel {
  int? sesaId;
  int? branchId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  Branch? branch;

  UserModel.fromJson(Map<String, dynamic> json) {
    sesaId = json['sesa_id'];
    branchId = json['branch_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];

    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sesa_id'] = sesaId;
    data['branch_id'] = branchId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}

class Branch {
  String? name;
  int? id;

  Branch({this.name, this.id});

  Branch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
