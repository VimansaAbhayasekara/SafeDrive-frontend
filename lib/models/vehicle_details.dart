class VehicleDetails {
  String? id;
  String? category;
  String? description;
  String? installationDate;
  String? renewalDate;

  VehicleDetails({
    this.id,
    this.category,
    this.description,
    this.installationDate,
    this.renewalDate,
  });

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    category = json['category'];
    description = json['description'];
    installationDate = json['installationDate'];
    renewalDate = json['renewalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['category'] = category;
    data['description'] = description;
    data['installationDate'] = installationDate;
    data['renewalDate'] = renewalDate;
    return data;
  }
}
